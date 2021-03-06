# coding: utf-8
class ProjectsController < ApplicationController
  load_and_authorize_resource only: [ :new, :create, :update, :destroy, :send_to_analysis ]
  inherit_resources
  has_scope :pg_search, :by_category_id, :near_of
  has_scope :recent, :expiring, :successful, :recommended, :not_expired, type: :boolean

  respond_to :html
  respond_to :json, only: [:index, :show, :update]

  before_action :ensure_stripe_is_setup, only: [:new, :create]
  before_action :ensure_user_has_less_than_max_projects, only: [:new, :create]

  def index
    index! do |format|
      format.html do
        if request.xhr?
          @projects = apply_scopes(Project).visible.order_for_search.includes(:project_total, :user, :category).page(params[:page]).per(6)
          return render partial: 'project', collection: @projects, layout: false
        else
          @title = t("site.title")

          if current_user && current_user.recommended_projects.present?
            @recommends = current_user.recommended_projects.limit(4)
          else
            @recommends = ProjectsForHome.recommends
          end

          @channel_projects = Project.from_channels([1]).order_for_search.limit(3)
          @projects_near = Project.with_state('online').near_of(current_user.address_county).order("random()").limit(3) if current_user
          @expiring = ProjectsForHome.expiring
          @recent   = ProjectsForHome.recents
        end
      end
    end
  end

  def new
    new! do
      @title = t('projects.new.title')
      @project.rewards.build
    end
  end

  def create
    @project = current_user.projects.new(params[:project])

    create! { project_by_slug_path(@project.permalink) }
  end

  def send_to_analysis
    resource.send_to_analysis
    flash[:notice] = t('projects.send_to_analysis')
    redirect_to project_by_slug_path(@project.permalink)
  end

  def update
    update!(notice: t('projects.update.success')) { project_by_slug_path(@project.permalink, anchor: 'edit') }
  end

  def show
    @title = resource.name
    fb_admins_add(resource.user.facebook_id) if resource.user.facebook_id
    @updates_count = resource.updates.count
    @update = resource.updates.where(id: params[:update_id]).first if params[:update_id].present?
    check_for_stripe_keys
  end

  def video
    project = Project.new(video_url: params[:url])
    render json: project.video.to_json
  end

  %w(embed video_embed).each do |method_name|
    define_method method_name do
      @title = resource.name
      render layout: 'embed'
    end
  end

  def embed_panel
    @title = resource.name
    render layout: false
  end

  protected

  def ensure_user_has_less_than_max_projects
    if current_user.projects.online_or_waiting.count > User::MAX_PROJECTS
      flash[:error] = t('only_n_projects_allowed', scope: 'flashes.user', total: User::MAX_PROJECTS)
      redirect_to root_path
    end
  end

  def ensure_stripe_is_setup
    if current_user.stripe_userid.blank?
      flash[:notice] = t('.please_connect_with_stripe')
      redirect_to(user_path(id: current_user.id, anchor: 'settings'))
    end
  end

  def check_for_stripe_keys
    return if @project.user.stripe_userid.blank?

    if @project.stripe_userid.nil?
      [:stripe_access_token, :stripe_key, :stripe_userid].each do |field|
        @project.send("#{field.to_s}=", @project.user.send(field).dup)
      end
    elsif @project.stripe_userid != @project.user.stripe_userid
      [:stripe_access_token, :stripe_key, :stripe_userid].each do |field|
        @project.send("#{field.to_s}=", @project.user.send(field).dup)
      end
    end
    @project.save
  end

  def resource
    @project ||= (params[:permalink].present? ? Project.by_permalink(params[:permalink]).first! : Project.find(params[:id]))
  end
end
