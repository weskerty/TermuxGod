#!/bin/bash

git fetch origin main
git merge --strategy-option ours origin/main || git pull --rebase --autostash

# Agregar, confirmar y subir cambios
git add .
git commit -m "Termux $(date +%Y-%m-%d)" 2>/dev/null || echo "No hay cambios"
git push origin main

