class AttachmentsController < ApplicationController

  before_action :load_attachment

  def destroy
    flash[:notice] = "File successfully deleted!" if @attachment.attachable.user_id == current_user.id && @attachment.destroy
  end

  private

  def load_attachment
    @attachment = Attachment.find(params[:id])
  end


end