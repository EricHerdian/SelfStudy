GDPC                �                                                                      
   `   res://.godot/exported/133200997/export-17c1db53e9ceaeb4caf2bfb4af535c5f-JobSelectionScene.scn   @            W��Hd
b��3����    ,   res://.godot/global_script_class_cache.cfg  P(             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex             ：Qt�E�cO���       res://.godot/uid_cache.bin  0,      �      ӭ\½��#^.��       res://icon.svg  p(      �      k����X3Y���f       res://icon.svg.import    '      �       N�K/���7}v+�Y�       res://project.binary�.      �      m �Hn�J�����م       res://resource/class.csv        <      )��]m̔TQ�\���$�    (   res://scene/JobSelectionScene.tscn.remap�'      n       ����J��07n���3�    $   res://script/JobSelectionScene.gd   `      �      #�[U.�[��Ө�B    ﻿ID,JOBNAME,DESCRIPTION,SKILLS
1,Warrior,A strength focused job. Warrior uses a two handed sword.,Slash;Break Shield;Parry;
2,Mage,An intelligence focused job. Mage uses magic to damage enemies or support allies.,Fire;Ice;Cure;
3,Thief,An agility focused job. Thief uses a dagger.,Agility Boost;Stealth;Steal;
    RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    content_margin_left    content_margin_top    content_margin_right    content_margin_bottom 	   bg_color    draw_center    skew    border_width_left    border_width_top    border_width_right    border_width_bottom    border_color    border_blend    corner_radius_top_left    corner_radius_top_right    corner_radius_bottom_right    corner_radius_bottom_left    corner_detail    expand_margin_left    expand_margin_top    expand_margin_right    expand_margin_bottom    shadow_color    shadow_size    shadow_offset    anti_aliasing    anti_aliasing_size    script 	   _bundled       Script "   res://script/JobSelectionScene.gd ��������      local://StyleBoxFlat_iilxq �         local://StyleBoxFlat_2mqnf          local://StyleBoxFlat_gll8v �         local://PackedScene_furlk          StyleBoxFlat                        �?         StyleBoxFlat          �>�>�>  �?	         
                                   �?  �?  �?  �?         StyleBoxFlat          ��?f?��?  �?	         
                                   �?  �?  �?  �?         PackedScene          	         names "   /      Control    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    Panel    theme_override_styles/panel    OptionButton    anchor_left    anchor_top    offset_left    offset_top    offset_right    offset_bottom !   theme_override_colors/font_color $   theme_override_font_sizes/font_size    metadata/_edit_use_anchors_    GridContainer &   theme_override_constants/h_separation    columns    JobBoxPanel    size_flags_horizontal    size_flags_vertical    JobBoxContainer $   theme_override_constants/separation    VBoxContainer    MarginContainer %   theme_override_constants/margin_left $   theme_override_constants/margin_top &   theme_override_constants/margin_right    JobName    text    horizontal_alignment    Label    MarginContainer2    JobDescription    custom_minimum_size    autowrap_mode    SkillBoxPanel '   theme_override_constants/margin_bottom    SkillTitle    SkillBoxContainer     _on_option_button_item_selected    item_selected    	   variants    &                    �?                                   ����   B`e<   ֭y=   "�F>   ��=   o�     ��   ��>   �ƻA     �?  �?  �?  �?               a��=   QR>   t�b?   �a?   p�3�   ���   �3@   w�@                     �C         
      	   Job Name 
     HC                "Job Description"                Skill List       node_count             nodes       ��������        ����                                                                ����                                       	                  
   
   ����                        	      
                                                                                 ����                                                                                                              ����                       	                       ����                                            ����                                       $   !   ����               "       #                    %   ����                                 $   &   ����   '   !            "   "   #   (                    )   ����                       	   $       
             ����                                        *                       ����                          $   +   ����                     "   %   #                    ,   ����                   conn_count             conns               .   -                    node_paths              editable_instances              version             RSRC         extends Control

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
               GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�m�m۬�}�p,��5xi�d�M���)3��$�V������3���$G�$2#�Z��v{Z�lێ=W�~� �����d�vF���h���ڋ��F����1��ڶ�i�엵���bVff3/���Vff���Ҿ%���qd���m�J�}����t�"<�,���`B �m���]ILb�����Cp�F�D�=���c*��XA6���$
2#�E.@$���A.T�p )��#L��;Ev9	Б )��D)�f(qA�r�3A�,#ѐA6��npy:<ƨ�Ӱ����dK���|��m�v�N�>��n�e�(�	>����ٍ!x��y�:��9��4�C���#�Ka���9�i]9m��h�{Bb�k@�t��:s����¼@>&�r� ��w�GA����ը>�l�;��:�
�wT���]�i]zݥ~@o��>l�|�2�Ż}�:�S�;5�-�¸ߥW�vi�OA�x��Wwk�f��{�+�h�i�
4�˰^91��z�8�(��yޔ7֛�;0����^en2�2i�s�)3�E�f��Lt�YZ���f-�[u2}��^q����P��r��v��
�Dd��ݷ@��&���F2�%�XZ!�5�.s�:�!�Њ�Ǝ��(��e!m��E$IQ�=VX'�E1oܪì�v��47�Fы�K챂D�Z�#[1-�7�Js��!�W.3׹p���R�R�Ctb������y��lT ��Z�4�729f�Ј)w��T0Ĕ�ix�\�b�9�<%�#Ɩs�Z�O�mjX �qZ0W����E�Y�ڨD!�$G�v����BJ�f|pq8��5�g�o��9�l�?���Q˝+U�	>�7�K��z�t����n�H�+��FbQ9���3g-UCv���-�n�*���E��A�҂
�Dʶ� ��WA�d�j��+�5�Ȓ���"���n�U��^�����$G��WX+\^�"�h.���M�3�e.
����MX�K,�Jfѕ*N�^�o2��:ՙ�#o�e.
��p�"<W22ENd�4B�V4x0=حZ�y����\^�J��dg��_4�oW�d�ĭ:Q��7c�ڡ��
A>��E�q�e-��2�=Ϲkh���*���jh�?4�QK��y@'�����zu;<-��|�����Y٠m|�+ۡII+^���L5j+�QK]����I �y��[�����(}�*>+���$��A3�EPg�K{��_;�v�K@���U��� gO��g��F� ���gW� �#J$��U~��-��u���������N�@���2@1��Vs���Ŷ`����Dd$R�":$ x��@�t���+D�}� \F�|��h��>�B�����B#�*6��  ��:���< ���=�P!���G@0��a��N�D�'hX�׀ "5#�l"j߸��n������w@ K�@A3�c s`\���J2�@#�_ 8�����I1�&��EN � 3T�����MEp9N�@�B���?ϓb�C��� � ��+�����N-s�M�  ��k���yA 7 �%@��&��c��� �4�{� � �����"(�ԗ�� �t�!"��TJN�2�O~� fB�R3?�������`��@�f!zD��%|��Z��ʈX��Ǐ�^�b��#5� }ى`�u�S6�F�"'U�JB/!5�>ԫ�������/��;	��O�!z����@�/�'�F�D"#��h�a �׆\-������ Xf  @ �q�`��鎊��M��T�� ���0���}�x^�����.�s�l�>�.�O��J�d/F�ě|+^�3�BS����>2S����L�2ޣm�=�Έ���[��6>���TъÞ.<m�3^iжC���D5�抺�����wO"F�Qv�ږ�Po͕ʾ��"��B��כS�p�
��E1e�������*c�������v���%'ž��&=�Y�ް>1�/E������}�_��#��|������ФT7׉����u������>����0����緗?47�j�b^�7�ě�5�7�����|t�H�Ե�1#�~��>�̮�|/y�,ol�|o.��QJ rmϘO���:��n�ϯ�1�Z��ը�u9�A������Yg��a�\���x���l���(����L��a��q��%`�O6~1�9���d�O{�Vd��	��r\�՜Yd$�,�P'�~�|Z!�v{�N�`���T����3?DwD��X3l �����*����7l�h����	;�ߚ�;h���i�0�6	>��-�/�&}% %��8���=+��N�1�Ye��宠p�kb_����$P�i�5�]��:��Wb�����������ě|��[3l����`��# -���KQ�W�O��eǛ�"�7�Ƭ�љ�WZ�:|���є9�Y5�m7�����o������F^ߋ������������������Р��Ze�>�������������?H^����&=����~�?ڭ�>���Np�3��~���J�5jk�5!ˀ�"�aM��Z%�-,�QU⃳����m����:�#��������<�o�����ۇ���ˇ/�u�S9��������ٲG}��?~<�]��?>��u��9��_7=}�����~����jN���2�%>�K�C�T���"������Ģ~$�Cc�J�I�s�? wڻU���ə��KJ7����+U%��$x�6
�$0�T����E45������G���U7�3��Z��󴘶�L�������^	dW{q����d�lQ-��u.�:{�������Q��_'�X*�e�:�7��.1�#���(� �k����E�Q��=�	�:e[����u��	�*�PF%*"+B��QKc˪�:Y��ـĘ��ʴ�b�1�������\w����n���l镲��l��i#����!WĶ��L}rեm|�{�\�<mۇ�B�HQ���m�����x�a�j9.�cRD�@��fi9O�.e�@�+�4�<�������v4�[���#bD�j��W����֢4�[>.�c�1-�R�����N�v��[�O�>��v�e�66$����P
�HQ��9���r�	5FO� �<���1f����kH���e�;����ˆB�1C���j@��qdK|
����4ŧ�f�Q��+�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://n2x7eqb2i2d2"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 [remap]

path="res://.godot/exported/133200997/export-17c1db53e9ceaeb4caf2bfb4af535c5f-JobSelectionScene.scn"
  list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
              
H��_S�8"   res://scene/JobSelectionScene.tscnOl���uW"(   res://resource/class.JOBNAME.translationD�1�i|*,   res://resource/class.DESCRIPTION.translationX �V��G'   res://resource/class.SKILLS.translation�ԝ�p�[   res://resource/class.csv}�����t   res://icon.svg��x��kf(   res://resource/class.JOBNAME.translationwE��Q,   res://resource/class.DESCRIPTION.translation1_�(�&z'   res://resource/class.SKILLS.translation9�=����   res://resource/class.csv����>�(   res://resource/class.JOBNAME.translation5,F���8,   res://resource/class.DESCRIPTION.translationK��B�� '   res://resource/class.SKILLS.translation��z7q~fO   res://resource/class.csv           ECFG      application/config/name         RPGJobSystem   application/run/main_scene,      "   res://scene/JobSelectionScene.tscn     application/config/features(   "         4.2    GL Compatibility       application/config/icon         res://icon.svg  !   importer_defaults/csv_translation<               compress         	   delimiter          #   rendering/renderer/rendering_method         gl_compatibility*   rendering/renderer/rendering_method.mobile         gl_compatibility   