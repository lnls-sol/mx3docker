#!/bin/bash

# This is already added by pyqtargs
echo "export PYTHONPATH=\$PYTHONPATH:/usr/local/sol/GUI/sol-widgets/" >> /etc/bash.bashrc

echo "export PYQTDESIGNERPATH=\$PYQTDESIGNERPATH:/usr/local/sol/GUI/sol-widgets/" >> /etc/bash.bashrc

# Link executable scripts and ui files of sol-widgets
for i in /usr/local/sol/GUI/sol-widgets/examples/motor/*; do
    if [[ -x "$i" ]]
    then
        echo "File '$i' is executable"
        ln -sf $i /usr/local/bin/`basename $i`
    fi

    if [[ $i == *.ui ]]
    then
        echo "File '$i' is ui"
        ln -sf $i /usr/local/bin/`basename $i`
    fi
done

for i in /usr/local/sol/GUI/sol-widgets/examples/imageview/*; do
    if [[ -x "$i" ]]
    then
        echo "File '$i' is executable"
        ln -sf $i /usr/local/bin/`basename $i`
    fi

    if [[ $i == *.ui ]]
    then
        echo "File '$i' is ui"
        ln -sf $i /usr/local/bin/`basename $i`
    fi
done

ln -fs /usr/local/sol/GUI/sol-widgets/examples/motor/motors_gui.py /usr/local/bin/motors_gui.py
ln -fs /usr/local/sol/GUI/sol-widgets/examples/motor/slits_gui.py /usr/local/bin/slits_gui.py

echo ">> sol-widgets added"
