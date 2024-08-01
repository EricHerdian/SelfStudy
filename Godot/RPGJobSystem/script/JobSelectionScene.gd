extends Control

var jobs = {}
@onready var option_button = $OptionButton
@onready var job_name = $GridContainer/JobBoxPanel/JobBoxContainer/MarginContainer/JobName
@onready var job_description = $GridContainer/JobBoxPanel/JobBoxContainer/MarginContainer2/JobDescription
@onready var skills_container = $GridContainer/SkillBoxPanel/MarginContainer/VBoxContainer/SkillBoxContainer

func _ready():
	readFile()
	setDropbox()
	updateView(option_button.get_selected_id())

# Function to read job csv file
func readFile():
	var file_path = "res://resource/class.csv"
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file:
		file.get_line()
		
		while not file.eof_reached():
			var csv_data = file.get_line().split(",")
			if csv_data.size() == 4:
				var job_id = csv_data[0]
				@warning_ignore("shadowed_variable")
				var job_name = csv_data[1]
				@warning_ignore("shadowed_variable")
				var job_description = csv_data[2]
				var skill_list = csv_data[3].split(";")
				jobs[int(job_id)] = {"JOBNAME": job_name, "DESCRIPTION": job_description, "SKILLS": skill_list}
		file.close()
	else:
		print("File not found")

# Function to set the dropbox
func setDropbox():
	for id in jobs.keys():
		var current_job = jobs[id]
		option_button.add_item(current_job["JOBNAME"])

# Function to update the view based on current selected job
func updateView(index):
	# Remove Skills List
	for child in skills_container.get_children():
		child.queue_free()
	
	# Search Job
	var selected_job_name = option_button.get_item_text(index)
	
	var job_id = -1
	for id in jobs.keys():
		if jobs[id]["JOBNAME"] == selected_job_name:
			job_id = id
			break
	
	# Updating View
	if job_id != -1:
		var current_job = jobs[job_id]
		
		# Update Label
		job_name.text = current_job["JOBNAME"]
		job_description.text = "\"" + current_job["DESCRIPTION"] + "\""
		
		# Update Skill
		for skill in current_job["SKILLS"]:
			var skill_label = Label.new()
			skill_label.text = skill
			skill_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			skill_label.add_theme_font_size_override("font_size", 24)
			skills_container.add_child(skill_label)

func _on_option_button_item_selected(index):
	updateView(index)
