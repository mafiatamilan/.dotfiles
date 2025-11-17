{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    clock24 = true;
    terminal = "screen-256color";

    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
      continuum
    ];

    extraConfig = ''
      ##### Core ####################################################
      set -g default-terminal "screen-256color"
      set -g status-interval 2
      set -g escape-time 10
      set -g assume-paste-time 1
      set -gq allow-passthrough on

      ##### Status bar (square) #####################################
      set -g status-style "bg=#11111b,fg=#cdd6f4"
      set -g status-left-length 0
      set -g status-right-length 100
      set -g status-justify left          # window list starts at left edge
      set -g status-left ""               # no left badge

      # Window list (square blocks)
      setw -g window-status-separator "  "
      setw -g window-status-format "#[fg=#a6adc8,bg=#11111b]  #I:#W  "
      setw -g window-status-current-format "#[fg=#0b0b10,bg=#89b4fa,bold]  #I:#W  "
      # Optional truncation if names get long:
      # setw -g window-status-format         "#[fg=#a6adc8,bg=#11111b]  #I:#{cut -c1-24 #W}  "
      # setw -g window-status-current-format "#[fg=#0b0b10,bg=#89b4fa,bold]  #I:#{cut -c1-24 #W}  "

      # Right side (square style): user@host · cwd (basename) · git branch
      set -g status-right "\
#[fg=#b4befe,bg=#11111b]  #[fg=#0b0b10,bg=#b4befe,bold]  #(whoami)@#H  #[fg=#cdd6f4,bg=#11111b]  \
#[fg=#a6e3a1,bg=#11111b]  #[fg=#0b0b10,bg=#a6e3a1,bold]  #{b:pane_current_path:t}  #[fg=#cdd6f4,bg=#11111b]  \
#[fg=#89b4fa,bg=#11111b]  #[fg=#0b0b10,bg=#89b4fa,bold]  #(git -C #{pane_current_path} rev-parse --abbrev-ref HEAD 2>/dev/null || echo '-')  "

      ##### Zellij-like keybindings (leader = Ctrl-g) ###############
      unbind C-b
      set -g prefix C-g
      bind C-g send-prefix

      # Navigate panes with h/j/k/l
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Splits: v (vertical side-by-side), s (horizontal top/bottom)
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      # Resize (leader then Shift+H/J/K/L)
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 2
      bind -r K resize-pane -U 2
      bind -r L resize-pane -R 5

      # Swap panes (valid flags only): up/down relative
      bind '{' swap-pane -U
      bind '}' swap-pane -D
      # Optional: swap with next/prev by explicit target
      # bind '<' swap-pane -t :.-
      # bind '>' swap-pane -t :.+

      # Rotate/zoom/copy-paste
      bind R rotate-window
      bind z resize-pane -Z
      bind y copy-mode
      bind p paste-buffer

      # Windows (tabs)
      bind t new-window -c "#{pane_current_path}"
      bind T command-prompt -I "#W" "rename-window '%%'"
      bind n next-window
      bind p previous-window
      bind w choose-window
      bind '(' swap-window -t -1
      bind ')' swap-window -t +1

      # Kill
      bind x kill-pane
      bind X kill-window

      # Sessions
      bind S new-session -A -s main
      bind s choose-tree -Zw
      bind $ command-prompt -I "#S" "rename-session '%%'"

      # Alt+number to jump windows
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9
      bind -n M-0 last-window

      # QoL
      bind r source-file ~/.tmux.conf \; display-message "tmux reloaded"
      set -g repeat-time 250
      set -g focus-events on

      ##### Visuals #################################################
      set -g pane-border-style "fg=#2a2a36"
      set -g pane-active-border-style "fg=#89b4fa"
      set -g display-panes-active-colour "#89b4fa"
      set -g display-panes-colour "#2a2a36"
      set -g message-style "bg=#21212b,fg=#cdd6f4"
      set -g message-command-style "bg=#21212b,fg=#cdd6f4"
      setw -g mode-style "bg=#2a2a36,fg=#cdd6f4"

      # Truecolor passthrough for terminals that support it
      set -as terminal-features ",xterm-256color:RGB,alacritty:RGB,screen-256color:RGB"
      set -as terminal-overrides ",xterm-256color:Tc,alacritty:Tc,screen-256color:Tc"
    '';
  };
}

