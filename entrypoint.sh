#! /bin/sh

EMACS_DIR=$HOME/.emacs.d/
EMACS_ELPA_DIR=$EMACS_DIR/elpa/
EMACS_INIT_FILE=$EMACS_DIR/init.el

echo "inside entry point."

# which git
ls -lrt /usr/bin/


ls -lrt /usr/share/
# which emacs

if [ "$1" = emacs -a ! -d "$EMACS_ELPA_DIR" -a -n "$EMACS_PACKAGES" ]; then
	cat > /tmp/melpa.el <<EOF
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
EOF
	emacs -batch -l /tmp/melpa.el -f package-refresh-contents
	rm -f /tmp/melpa.el
fi

exec "$@"
