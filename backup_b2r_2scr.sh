#!/bin/bash
echo entering scr/buildroot
cd $WORKAREA/scr/buildroot

echo generate folder structure
mkdir -p ./board/melp/nova

echo backup
cp $WORKAREA/buildroot/board/melp/nova/* ./board/melp/nova

echo done
ls ./board/melp/nova
