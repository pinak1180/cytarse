class StaticController < ApplicationController
  def thank_you
    contribution = Contribution.find session[:thank_you_contribution_id]
    redirect_to [contribution.project, contribution]
  end

  def terms
    @title = t('static.terms.title')
  end

  def contact
    @title = t('static.contact.title')
  end
end
