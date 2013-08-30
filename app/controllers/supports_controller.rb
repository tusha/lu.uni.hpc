class SupportsController < ApplicationController
  
 def create
    @support=Support.new(params[:support])
    if @support.save
      redirect_to(:back, :notice=>"Mail successfully sent.")
    else
      flash[:alert]="You must fill all the fields."
      redirect_to(:back, :notice=>"You must fill all the fields.")
    end
  end
end
