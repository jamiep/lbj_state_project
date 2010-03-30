class DataViewController < ApplicationController
  def home
    @years = [['2008',2008], ['2009',2009]]
    @agencies = [['Comptroller Object', 'CO'], ['Comptroller Object Category Type', 'COCT'], 
                ['Vendor Payee Display Name', 'VPDN']]
  end

  def view
    @records = Record.all(:limit => 10)
    
  end

end
