function echo_colored
	set -l text $argv[1]
	set -l insert_whitespace $argv[2]
	set -l fg_color $argv[3]
	set -l bg_color $argv[4]

	if test -n "$bg_color"
		set_color -b $bg_color
	end

	if test -n "$fg_color"
		set_color $fg_color
	end

	echo -n -s $text

	if [ "$insert_whitespace" = true ]
		set_color normal; set_color -b normal
		echo -n -s " "
	end

end

function show_virtualenv
	if set -q VIRTUAL_ENV
		echo_colored "(.virtualenv)"
	end
end

function show_whatami
	# ami root or not ?
	set_color --bold
	echo_colored "~" true blue
	set_color --normal
end

function show_prompt
	echo_colored "\$" true ccc
end

function show_status
	if test $LAST_RETCODE -ne 0
		set_color --bold
		echo_colored " ↑ $LAST_RETCODE " true black red
		set_color --normal
	end
end

function show_whereami
	echo_colored (prompt_pwd) true brblue
end

function fish_prompt
	set -g LAST_RETCODE $status

	# erase the previous line content.
	echo -e -n "\r"
#	show_whatami
	show_status
	show_whereami
	show_prompt
end
