class CertificateVerificationsController < ApplicationController

	before_action :authorize_request

  

  def index
      @certificate_verification = CertificateVerification.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
      # render json: @certificate_verification

      total_count = @certificate_verification.count
      per_page = 5
  ratio = (total_count.to_f / per_page).ceil

   if @certificate_verification.empty?
    render json: { message: 'No records found' }, status: :ok
  else

        render json: {
          certificate_verification: @certificate_verification,
          total_pages: ratio
        }, status: :ok


            # render json: @certificate_verification
       

        end
  end   

  def create
    params.merge!(user_id: @current_user.id) if params.present?
    @certificate_verification = CertificateVerification.new(certificate_verification_params)

    if @certificate_verification.save
      render json: @certificate_verification, status: :created
    else
      render json: @certificate_verification.errors, status: :unprocessable_entity
    end
  end

  def update
    @certificate_verification = CertificateVerification.find(params[:id])

    if @certificate_verification.update(certificate_verification_params)
      render json: @certificate_verification
    else
      render json: @certificate_verification.errors, status: :unprocessable_entity
    end
  end

  def destroy
      @certificate_verification = CertificateVerification.find_by_id(params[:id])
   if @certificate_verification.destroy
      render json: @certificate_verification, status: :created
    else
      render json: { errors: "Record not found or deleted.." },
             status: :unprocessable_entity
   end     
    end

  

  private

  def certificate_verification_params
    params.permit( :message, :note, :user_id, :expert_id, :status)
  end
end
