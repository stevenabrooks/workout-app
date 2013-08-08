class RoutinesController < ApplicationController
  # GET /routines
  # GET /routines.json
  def index
    @routines = Routine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @routines }
    end
  end

  # GET /routines/1
  # GET /routines/1.json
  def show
    @routine = Routine.find(params[:id])
    @graph = @routine.graph

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @routine }
    end
  end

  # GET /routines/new
  # GET /routines/new.json
  def new
    @routine = Routine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @routine }
    end
  end

  # GET /routines/1/edit
  def edit
    @routine = Routine.find(params[:id])
  end

  # POST /routines
  # POST /routines.json
  def create
    # raise params.inspect
    @routine = Routine.new(:name => params[:routine][:name])
    @routine.date = params[:routine][:date]
    @routine.save

    params[:lifts].each do |lift|
      lift.each do |k,v|
        exercise = Exercise.find_or_create_by_name(v[:exercise_name])
        lift = Lift.create(:exercise_id => exercise.id, :routine_id => @routine.id)
        exercise_array = v[:infos]
        exercise_array.each do |hash_of_info|
          info = Info.create(hash_of_info)
          info.lift_id = lift.id
          info.save
        end
      end
    end

    # exercise_hash = params[:lifts]
    # exercise = Exercise.find(exercise_hash[:exercise_id].to_i)
    # lift = Lift.create(:exercise_id => exercise.id, :routine_id => @routine.id)
    # exercise_hash[:infos].each do |hash_of_info|
    #   info = Info.create(hash_of_info)
    #   info.lift_id = lift.id
    #   info.save
    # end

# -------------------------------------    
# "routine"=>{
#   "name"=>"Test Routine"},
#   "lifts"=>[
#     {"0"=>{
#       "exercise_id"=>"1",
#       "infos"=>[
#         {"weight"=>"155", "repetition"=>"8"}]},
#     "1"=>{
#       "exercise_id"=>"4",
#       "infos"=>[
#         {"weight"=>"205", "repetition"=>"4"}]}}]
# -----------------------------------------

 # -----------------------------   
 # :lift => {:exercise_id => 1, 
 #    :infos => [
 #      {:weight => "250", :repetition => "8"}, 
 #      {:weight => "250", :repetition => "8"}
 #      ]}
 # -----------------------------


    respond_to do |format|
      if @routine.persisted?
          # puts "#"*15
          # puts @routine.lifts
          # puts "#"*15
        format.html { redirect_to @routine, notice: 'Routine was successfully created.' }
        format.json { render json: @routine, status: :created, location: @routine }
      else
        format.html { render action: "new" }
        format.json { render json: @routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /routines/1
  # PUT /routines/1.json
  def update
    @routine = Routine.find(params[:id])

    respond_to do |format|
      if @routine.update_attributes(params[:routine])
        format.html { redirect_to @routine, notice: 'Routine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @routine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routines/1
  # DELETE /routines/1.json
  def destroy
    @routine = Routine.find(params[:id])
    @routine.destroy

    respond_to do |format|
      format.html { redirect_to routines_url }
      format.json { head :no_content }
    end
  end
end
