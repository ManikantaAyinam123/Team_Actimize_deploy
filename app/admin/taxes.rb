ActiveAdmin.register_page 'Calculator' do
  menu label: 'Pay Slip'
  controller do
    def index
    if params[:salary].present?
      @sal = params[:salary].to_f
      @salary = @sal/12.0
      @basic = @salary*60.0/100.0
      @hra = @salary*24.0/100.0
      @conveyance = @salary*4.8/100.0
      @medical = @salary*2.5/100.0
      @other = @salary*8.7/100.0
      @tds = tax_calculations_new(@sal)
      @tdss = tax_calculationss(@sal)
      @tds_mnth = @tds/12.0
      @tdss_mnth = @tdss/12.0
    
      @details = {"Basic" => @basic.round(2),"HRA" => @hra.round(2),"Conveyance" => @conveyance.round(2),"Medical" => @medical.round(2),"Other" => @other.round(2),"Deductions"=>{"Professional Tax" => 200,"TDS-Monthly" => {"New"=>@tds_mnth.round(2),"Old"=>@tdss_mnth.round(2)}},"Total Salary"=>@salary.round(2),"Net Salary" => {"New"=>(@salary-@tds_mnth.round(2)-200).round(2),"Old"=>(@salary-@tdss_mnth.round(2)-200).round(2)},"Total CTC"=>@sal,"TDS-Yearly"=>{"New"=>@tds.round(2),"Old"=>@tdss.round(2)} }
         
      end 
    end 
    def tax_calculations_new(salary)
        sal = salary
        @sall =sal-50000.0
         if @sall <= 700000
           @sl = 0 
           return @sl
         elsif (@sall>700000 && @sall<=900000)
          a = 15000
          x = @sall-700000.0
          b = x*10.0/100.0
            if ((a+b)>=x)
               @sl = x+x*4.0/100
               return @sl
              else
                x = @sall-600000.0
                  b = x*10.0/100.0
              end
         elsif (@sall>900000 && @sall<=1200000)
          a = 45000
          x = @sall-900000.0
          b = x*15.0/100.0
         elsif (@sall>1200000 && @sall<=1500000)
          a = 90000
          x = @sall-1200000.0
          b = x*20.0/100.0
       else       
          a = 150000
          x = @sall-1500000.0
          b = x*30.0/100.0
         end
           cess = (a+b)*4.0/100.0
           @sl = a+b+cess.round(0)
          return @sl
    end


    def tax_calculationss(salary)
        sal = salary
        @saly =sal-50000.0-2400.0
          if @saly <= 500000
             @sll = 0 
             return @sll
          elsif (@saly>500000 && @saly<=1000000)
             a = 12500
             b = (@saly-500000.0)*20.0/100.0
          else
             a = 112500
             b = (@saly-1000000.0)*30.0/100.0
          end 
             cess = (a+b)*4.0/100.0
             @sll = a+b+cess.round(0)     
          return @sll
    end
end

  
  content title: 'Pay Slip' do
   div(style: 'text-align: center;')do

  form action: 'calculator', method: :get do |f|
    h6 'Salary :', style: 'display: inline-block; font-size: 26px; margin-right: 10px; margin-top: 18px '
    input :salary, type: :text, name: 'salary', style: 'display: inline-block; font-size: 16px; width: 280px'
    input :submit, type: :submit, value: 'Submit', style: 'display: inline-block; font-size: 21px; margin-left: 10px'
  end

  render partial: 'admin/calculators/details' 

  end

  
end

end

