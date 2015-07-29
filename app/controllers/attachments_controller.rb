class AttachmentsController < ApplicationController

  before_action :load_attachment

  def destroy
    @attachment.destroy
  end

  private

  def load_attachment
    @attachment = Attachment.find(params[:id])
  end


end