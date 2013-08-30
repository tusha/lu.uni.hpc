class JobsController < ApplicationController
  before_filter :require_user
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  helper_method :get_job_tokens

  # GET /jobs
  def index           
    @jobs = Job.all.where('user_id=?',current_user.id)    
    account=Account.find_by_user_id(current_user.id)
   if account != nil
     @script=account.script_name
    if @jobs != nil
     @jobs.each do |j|
       j.tokens_str=get_job_tokens(j.id)      
     end
    else
      redirect_to action: 'new'
    end
   else redirect_to action: 'new'
   end
  end
 
  # GET /jobs/new
  def new
    @job = Job.new
    @token_arr=[]
    get_user_tokens    
    account=Account.find_by_user_id(current_user.id)    
    if account != nil      
     get_user_scripts(account)
    end
  end

  # GET /jobs/1/edit
  def edit      
    if @account != nil          
     get_user_scripts(account)   
     
    end
    @job.token_amount =@job.tokens[]
  end

  # POST /jobs
  def create
    @job = Job.new(job_params)
    @job.tokens=[]     
     take_tokens(job_params[:token_id], job_params[:token_amount])
    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /jobs/1
  def update
    if @job.update(job_params)
      @job.tokens.push(job_params[:token_id], job_params[:token_amount])
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /jobs/1
  def destroy
    @job=Job.find_by_id(params[:id])
    @job.destroy
    redirect_to jobs_url, notice: 'Job was successfully destroyed.'
  end
  
  def user_tokens    
    account=Account.find_by_user_id(current_user.id)
    if account !=nil && account.tokens !=nil
       @cur_tokens=[]    
     account.tokens.each do |t|
       tok=Token.find_by_id(t[0])
      @cur_tokens << [tok.quality, tok.generation_num, tok.transform_num, tok.kind, t[1]]
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      account=Account.find_by_user_id(current_user.id)
      if account != nil
       get_user_tokens
       @job = Job.find(params[:id])
      else redirect_to action: 'new'
      end
    end

    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:id,:name, :user_id, :script_id, :token_id, :token_amount, :optional_params, :output_id, {:tokens => [:token_id, :token_amount]})
    end
    
    def get_user_tokens
      account=Account.find_by_user_id(current_user.id)
      if account != nil
      tokens=account.tokens
      @tokens_avail=[]
      tokens.each do |t| 
         tok=Token.find_by_id(t[0])    
         @tokens_avail<< [tok.quality, tok.generation_num, tok.transform_num, tok.kind, t[1], tok.id]                
      end
     end
    end
    
    def take_tokens(token_id, amount)
      account=Account.find_by_user_id(current_user.id)  
      if account != nil   
      account.tokens.each do |t|
        if t[0]==token_id
        ind=account.tokens.index(t)
        val=t[1].to_i - amount.to_i
        account.tokens.delete_at(ind)
        account.tokens << [token_id, val]
        account.tokens_will_change!
        account.save
        end       
      end   
     end   
    end
    
    def get_job_tokens(job_id)      
      @job_tokens=[]
      Job.find_by_id(job_id).tokens.each do |t|
         tok=Token.find_by_id(t[0])    
         @job_tokens << [tok.quality, tok.generation_num, tok.transform_num, tok.kind, t[1], tok.id]            
      end      
    end
    
    def get_user_scripts(account)
      @scripts=[]
      if account.script_url != nil
       @scripts << [account.script_name, account.id]
     else 
       @scripts << ['No script available', '00']
     end
    end
   
    
end
