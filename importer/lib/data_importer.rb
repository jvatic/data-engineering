require 'csv'

class DataImporter

  def self.process(data_file)
    new(data_file)
  end

  attr_reader :orders

  def initialize(data_file)
    @logger = Logger.new( File.join(Rails.root, 'log', 'importer.log') )

    @orders = []

    CSV.foreach(data_file, :col_sep => "\t", :skip_blanks => true, :headers => true) do |row|
      import_row(row)
    end
  end

  private

  def import_row(row)
    @logger.info "[Import] [#{Time.now}] #{row.inspect}"

    order = Order.new(
      :purchaser_name   => row["purchaser name"],
      :item_description => row["item description"],
      :item_price       => row["item price"].to_f,
      :purchase_count   => row["purchase count"].to_i,
      :merchant_address => row["merchant address"],
      :merchant_name    => row["merchant name"]
    )

    if order.save
      @orders << order
    else
      @logger.warn "[Failed] [#{Time.now}] #{row.inspect}"
    end
  end
end
