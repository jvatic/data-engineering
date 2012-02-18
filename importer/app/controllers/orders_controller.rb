class OrdersController < ApplicationController

  def new
    # display upload field
  end

  def import
    unless params[:orders] && params[:orders][:data_file]
      flash[:error] = "Please select a data file to import and try again!"
      return redirect_to :action => :new
    end

    import = DataImporter.process(params[:orders][:data_file].tempfile)
    @orders = import.orders
  end

end
