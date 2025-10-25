set fish_greeting
set -U fish_color_option white

function fish_prompt
    set -l cwd (pwd)
    set -l home $HOME

    if test $cwd = $home
        set cwd "~"
    else if string match -q -- "$home/*" $cwd
        set cwd "~"(string sub -s (math (string length $home) + 1) -- $cwd)
    end

    set_color blue
    echo -n (whoami)
    set_color normal

    echo -n '@'(hostname)':'$cwd '> '
end

