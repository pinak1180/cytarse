class ExploreController < ApplicationController
  def index
    @title = t('explore.title')

    @categories = Category.with_projects.order("name_#{I18n.locale}").all
  end
end
