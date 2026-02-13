#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# 🔥 TERMUX GESTOR DE ARCHIVOS DG  MEGA PACK 🔥
# Instalador automático con selector de temas
# By: El Brutal
# ==============================================

# Configuración de colores
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m'

# Detectar si es la primera ejecución
FIRST_RUN=0
[ ! -f "$HOME/.ultimate_installed" ] && FIRST_RUN=1

clear
echo -e "${CYAN}"
figlet -f big "TERMUX" 2>/dev/null || echo "🔥 TERMUX GESTOR DE ARCHIVOS DG  🔥"
figlet -f slant "ULTIMATE" 2>/dev/null || echo "⚡ MEGA PACK ⚡"
echo -e "${NC}"

echo -e "${PURPLE}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${PURPLE}║     🚀 INSTALADOR AUTOMÁTICO ULTIMATE v3.0 🚀       ║${NC}"
echo -e "${PURPLE}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

# Verificar e instalar dependencias automáticamente
echo -e "${YELLOW}[🔍] Verificando dependencias...${NC}"

# Lista completa de dependencias
DEPENDENCIAS=(
    "fzf"
    "eza"
    "bat"
    "nano"
    "vim"
    "tree"
    "neofetch"
    "htop"
    "ranger"
    "wget"
    "curl"
    "git"
    "termux-api"
    "ffmpeg"
    "imagemagick"
    "cmus"
    "mpv"
    "python"
    "nodejs"
    "tput"
    "figlet"
    "lolcat"
    "cmatrix"
    "ncdu"
    "duf"
    "glow"
    "tldr"
    "which"
    "man"
    "openssh"
    "rsync"
    "tmux"
    "zsh"
)

# Función para verificar e instalar
check_and_install() {
    for pkg in "${DEPENDENCIAS[@]}"; do
        echo -ne "${CYAN}   → $pkg ${NC}"
        if pkg list-installed 2>/dev/null | grep -q "^$pkg$"; then
            echo -e "${GREEN}✅ Instalado${NC}"
        else
            echo -e "${YELLOW}⏳ Instalando...${NC}"
            pkg install -y "$pkg" >/dev/null 2>&1
            if [ $? -eq 0 ]; then
                echo -e "\r   → $pkg ${GREEN}✅ Instalado${NC}"
            else
                echo -e "\r   → $pkg ${RED}❌ Falló${NC}"
            fi
        fi
    done
}

# Verificar e instalar
check_and_install

# Actualizar paquetes
echo -e "\n${YELLOW}[📦] Actualizando paquetes...${NC}"
pkg upgrade -y >/dev/null 2>&1

# ========== SELECTOR DE TEMAS ==========
if [ $FIRST_RUN -eq 1 ]; then
    echo -e "\n${PURPLE}╔════════════════════════════════════════╗${NC}"
    echo -e "${PURPLE}║     🎨 SELECTOR DE TEMAS VISUALES     ║${NC}"
    echo -e "${PURPLE}╚════════════════════════════════════════╝${NC}"
    echo ""
    
    TEMAS=(
        "1) 🌿 Hacker Green - Clásico Matrix"
        "2) 💜 Purple Dream - Estilo cyberpunk"
        "3) 🌊 Ocean Blue - Profesional relajante"
        "4) 🟠 Retro Amber - Vintage terminal"
        "5) 🌃 Cyberpunk 2077 - Futurista neón"
        "6) 🧛 Dracula - Oscuro elegante"
        "7) ❄️ Nord - Minimalista nórdico"
        "8) 🏔️ Gruvbox - Retro cálido"
        "9) ☀️ Solarized - Científico"
        "10) 🌈 Random - Sorpresa cada vez"
        "11) 🎲 Cambiar cada día"
    )
    
    for tema in "${TEMAS[@]}"; do
        echo -e "${CYAN}$tema${NC}"
    done
    
    echo ""
    echo -e "${YELLOW}Selecciona tu tema (1-11):${NC} "
    read -r TEMA_SELECCIONADO
    
    case $TEMA_SELECCIONADO in
        1) TEMA="hacker-green" ;;
        2) TEMA="purple-dream" ;;
        3) TEMA="ocean-blue" ;;
        4) TEMA="retro-amber" ;;
        5) TEMA="cyberpunk" ;;
        6) TEMA="dracula" ;;
        7) TEMA="nord" ;;
        8) TEMA="gruvbox" ;;
        9) TEMA="solarized" ;;
        10) TEMA="random" ;;
        11) TEMA="daily" ;;
        *) TEMA="hacker-green" ;;
    esac
    
    echo "$TEMA" > "$HOME/.current_theme"
else
    TEMA=$(cat "$HOME/.current_theme" 2>/dev/null || echo "hacker-green")
fi

# ========== APLICAR TEMA SELECCIONADO ==========
echo -e "\n${YELLOW}[🎨] Aplicando tema: ${CYAN}$TEMA${NC}"

# Crear directorios necesarios
mkdir -p "$HOME/.termux"
mkdir -p "$HOME/.config/ultimate"
mkdir -p "$HOME/.trash"
mkdir -p "$HOME/.sounds"
mkdir -p "$HOME/.wallpapers"

# Descargar módulos desde GitHub
echo -e "${YELLOW}[📥] Descargando módulos...${NC}"

# Aquí iría la descarga de los módulos desde tu repo
# Por ahora creamos los archivos localmente

# ========== CONFIGURACIÓN DEL TEMA ==========
cat > "$HOME/.termux/termux.properties" << 'EOF'
extra-keys = [['ESC','/','-','HOME','UP','END','PGUP'],['TAB','CTRL','ALT','LEFT','DOWN','RIGHT','PGDN']]
use-black-ui = true
bell-character = ignore
EOF

# Aplicar colores según tema
case $TEMA in
    "hacker-green")
        cat > "$HOME/.termux/colors.properties" << 'EOF'
background=#0f0f0f
foreground=#00ff00
cursor=#00ff00
color0=#0f0f0f
color1=#ff4444
color2=#00ff00
color3=#ffff00
color4=#4444ff
color5=#ff44ff
color6=#44ffff
color7=#ffffff
EOF
        PROMPT_COLOR="\[\033[0;32m\]"
        ;;
    "purple-dream")
        cat > "$HOME/.termux/colors.properties" << 'EOF'
background=#1a0b2e
foreground=#b792e8
cursor=#ff79c6
color0=#1a0b2e
color1=#ff5555
color2=#9b59b6
color3=#f1c40f
color4=#8e44ad
color5=#ff79c6
color6=#3498db
color7=#f8f8f2
EOF
        PROMPT_COLOR="\[\033[0;35m\]"
        ;;
    "ocean-blue")
        cat > "$HOME/.termux/colors.properties" << 'EOF'
background=#0a1f2e
foreground=#88c0d0
cursor=#88c0d0
color0=#0a1f2e
color1=#bf616a
color2=#a3be8c
color3=#ebcb8b
color4=#5e81ac
color5=#b48ead
color6=#88c0d0
color7=#e5e9f0
EOF
        PROMPT_COLOR="\[\033[0;34m\]"
        ;;
    "retro-amber")
        cat > "$HOME/.termux/colors.properties" << 'EOF'
background=#000000
foreground=#ffb000
cursor=#ffb000
color0=#000000
color1=#ff4400
color2=#ffb000
color3=#ffdd00
color4=#ff8800
color5=#ff5500
color6=#ffaa00
color7=#ffffaa
EOF
        PROMPT_COLOR="\[\033[0;33m\]"
        ;;
    "cyberpunk")
        cat > "$HOME/.termux/colors.properties" << 'EOF'
background=#0c0c1c
foreground=#00ffff
cursor=#ff00ff
color0=#0c0c1c
color1=#ff0066
color2=#00ff00
color3=#ffff00
color4=#00ffff
color5=#ff00ff
color6=#00ccff
color7=#ffffff
EOF
        PROMPT_COLOR="\[\033[0;36m\]"
        ;;
    *)
        # Tema por defecto
        cat > "$HOME/.termux/colors.properties" << 'EOF'
background=#1e1e2e
foreground=#cdd6f4
cursor=#f5e0dc
color0=#45475a
color1=#f38ba8
color2=#a6e3a1
color3=#f9e2af
color4=#89b4fa
color5=#cba6f7
color6=#94e2d5
color7=#bac2de
EOF
        PROMPT_COLOR="\[\033[0;36m\]"
        ;;
esac

# Aplicar configuración
termux-reload-settings 2>/dev/null

# ========== CREAR COMANDOS ULTIMATE ==========
echo -e "${YELLOW}[⚡] Creando comandos ultimate...${NC}"

cat > "$HOME/.config/ultimate/ultimate.sh" << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# 💀 COMANDOS ULTIMATE PRO 💀
# Versión: 3.0 - Mega Pack
# ==============================================

# Configuración
HIST_FILE="$HOME/.ultimate_history"
TRASH_DIR="$HOME/.trash"
SOUNDS_DIR="$HOME/.sounds"
WALLPAPERS_DIR="$HOME/.wallpapers"
CONFIG_DIR="$HOME/.config/ultimate"
CURRENT_THEME=$(cat "$HOME/.current_theme" 2>/dev/null || echo "default")

# Colores (se adaptan al tema)
source "$CONFIG_DIR/colors.sh" 2>/dev/null || {
    R='\033[0;31m'
    G='\033[0;32m'
    Y='\033[0;33m'
    B='\033[0;34m'
    P='\033[0;35m'
    C='\033[0;36m'
    W='\033[1;37m'
    N='\033[0m'
}

# ========== MENÚ PRINCIPAL INTERACTIVO ==========
menu() {
    while true; do
        clear
        echo -e "${C}╔══════════════════════════════════════════════════╗${N}"
        echo -e "${C}║     🔥 TERMUX GESTOR DE ARCHIVOS DG  MEGA PACK v3.0 🔥        ║${N}"
        echo -e "${C}╚══════════════════════════════════════════════════╝${N}"
        echo ""
        echo -e "${W}╔════════════════════════════════════════╗${N}"
        echo -e "${W}║         📌 CATEGORÍAS                  ║${N}"
        echo -e "${W}╚════════════════════════════════════════╝${N}"
        echo ""
        echo -e "${G}[1]${N} 📁 Gestión de Archivos"
        echo -e "${G}[2]${N} 🖼️  Multimedia"
        echo -e "${G}[3]${N} 📊 Monitor Sistema"
        echo -e "${G}[4]${N} 🌐 Red"
        echo -e "${G}[5]${N} 🎨 Temas Visuales"
        echo -e "${G}[6]${N} 🔧 Utilidades"
        echo -e "${G}[7]${N} 📚 Ayuda"
        echo -e "${G}[8]${N} 🚪 Salir"
        echo ""
        echo -e "${Y}Selecciona una opción:${N} "
        read -r opt
        
        case $opt in
            1) menu_archivos ;;
            2) menu_multimedia ;;
            3) menu_monitor ;;
            4) menu_red ;;
            5) menu_temas ;;
            6) menu_utilidades ;;
            7) mostrar_ayuda ;;
            8) exit 0 ;;
            *) echo -e "${R}Opción inválida${N}"; sleep 1 ;;
        esac
    done
}

# ========== MENÚ DE ARCHIVOS ==========
menu_archivos() {
    while true; do
        clear
        echo -e "${G}╔════════════════════════════════════════╗${N}"
        echo -e "${G}║         📁 GESTIÓN DE ARCHIVOS        ║${N}"
        echo -e "${G}╚════════════════════════════════════════╝${N}"
        echo ""
        echo -e "${W}[1]${N} 🔍 Navegador Ultra Visual (nav)"
        echo -e "${W}[2]${N} 📂 Explorador Doble Panel (exp)"
        echo -e "${W}[3]${N} 📜 Historial de navegación"
        echo -e "${W}[4]${N} 📋 Copiar archivos"
        echo -e "${W}[5]${N} ✂️  Mover archivos"
        echo -e "${W}[6]${N} 🗑️  Borrar (mover a papelera)"
        echo -e "${W}[7]${N} 🔄 Restaurar de papelera"
        echo -e "${W}[8]${N} 📦 Comprimir/Descomprimir"
        echo -e "${W}[9]${N} 🔍 Buscar archivos"
        echo -e "${W}[0]${N} ↩️  Volver"
        echo ""
        read -p "Opción: " opt
        
        case $opt in
            1) nav ;;
            2) exp ;;
            3) navhist ;;
            4) copiar ;;
            5) mover ;;
            6) borrar ;;
            7) papelera ;;
            8) comprimir ;;
            9) buscar ;;
            0) break ;;
        esac
    done
}

# ========== NAVEGADOR ULTRA VISUAL ==========
nav() {
    clear
    echo -e "${C}╔════════════════════════════════════════╗${N}"
    echo -e "${C}║     🔍 NAVEGADOR ULTRA VISUAL v3.0    ║${N}"
    echo -e "${C}╚════════════════════════════════════════╝${N}"
    echo ""
    
    local choice=$(find . -maxdepth 5 2>/dev/null | fzf \
        --preview '
            if [ -d {} ]; then
                echo "📁 DIRECTORIO:"
                eza -la --icons --color=always {} 2>/dev/null | head -30
                echo ""
                echo "📊 ESTADÍSTICAS:"
                du -sh {} 2>/dev/null
                find {} -type f 2>/dev/null | wc -l | xargs echo "📄 Archivos:"
            else
                echo "📄 ARCHIVO:"
                bat --color=always --style=numbers {} 2>/dev/null | head -30
                echo ""
                echo "ℹ️  INFORMACIÓN:"
                file -b {} 2>/dev/null
                du -h {} 2>/dev/null
            fi
        ' \
        --preview-window=right:60%:wrap \
        --height=90% \
        --border=double \
        --header="SPACE: Vista previa | ENTER: Abrir | CTRL+R: Renombrar | CTRL+D: Borrar | ESC: Salir" \
        --bind="ctrl-r:become(echo rename {})" \
        --bind="ctrl-d:become(echo delete {})" \
        --prompt="🔍 > ")
    
    if [ -n "$choice" ]; then
        echo "$PWD/$choice" >> "$HIST_FILE"
        if [ -d "$choice" ]; then
            cd "$choice"
            nav
        else
            abrir_archivo "$choice"
        fi
    fi
}

# ========== EXPLORADOR DOBLE PANEL ==========
exp() {
    clear
    echo -e "${P}╔════════════════════════════════════════╗${N}"
    echo -e "${P}║     📂 EXPLORADOR DOBLE PANEL v2.0    ║${N}"
    echo -e "${P}╚════════════════════════════════════════╝${N}"
    
    local dir1=$(pwd)
    local dir2=$(pwd)
    
    while true; do
        clear
        echo -e "${C}╔════════ PANEL 1 ═══════╗${N}"
        cd "$dir1" 2>/dev/null || dir1=~
        eza -la --icons --color=always | head -15
        echo ""
        echo -e "${Y}╔════════ PANEL 2 ═══════╗${N}"
        cd "$dir2" 2>/dev/null || dir2=~
        eza -la --icons --color=always | head -15
        
        echo ""
        echo -e "${W}[1] Navegar Panel 1"
        echo "[2] Navegar Panel 2"
        echo "[3] Copiar P1 → P2"
        echo "[4] Mover P1 → P2"
        echo "[5] Sincronizar directorios"
        echo "[6] Comparar contenido"
        echo "[7] Cambiar layout"
        echo "[0] Salir${N}"
        echo ""
        read -p "Opción: " opt
        
        case $opt in
            1) cd "$dir1"; nav; dir1=$(pwd) ;;
            2) cd "$dir2"; nav; dir2=$(pwd) ;;
            3) 
                echo "Selecciona archivo en Panel 1:"
                cd "$dir1"
                file=$(fzf)
                if [ -n "$file" ]; then
                    cp -rv "$file" "$dir2/"
                    echo -e "${G}✅ Copiado${N}"
                    sleep 1
                fi
                ;;
            4)
                echo "Selecciona archivo en Panel 1:"
                cd "$dir1"
                file=$(fzf)
                if [ -n "$file" ]; then
                    mv -v "$file" "$dir2/"
                    echo -e "${G}✅ Movido${N}"
                    sleep 1
                fi
                ;;
            5)
                echo -e "${Y}Sincronizando P1 → P2...${N}"
                rsync -av "$dir1/" "$dir2/"
                echo -e "${G}✅ Sincronizado${N}"
                sleep 1
                ;;
            6)
                echo "📁 Panel 1 vs Panel 2"
                diff -qr "$dir1" "$dir2" 2>/dev/null | head -20
                read -p "Enter para continuar..."
                ;;
            7)
                echo "Layouts: 1) Horizontal 2) Vertical"
                read -p "Selecciona: " layout
                # Aquí iría la lógica de layout
                ;;
            0) break ;;
        esac
    done
}

# ========== MULTIMEDIA ==========
menu_multimedia() {
    clear
    echo -e "${P}╔════════════════════════════════════════╗${N}"
    echo -e "${P}║         🖼️  MULTIMEDIA                  ║${N}"
    echo -e "${P}╚════════════════════════════════════════╝${N}"
    echo ""
    echo -e "${W}[1] Ver imágenes${N}"
    echo -e "${W}[2] Reproducir videos${N}"
    echo -e "${W}[3] Reproducir música${N}"
    echo -e "${W}[4] Grabar audio${N}"
    echo -e "${W}[5] Convertir formato${N}"
    echo -e "${W}[6] Tomar foto (cámara)${N}"
    echo -e "${W}[0] Volver${N}"
    echo ""
    read -p "Opción: " opt
    
    case $opt in
        1)
            find /sdcard -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif" \) 2>/dev/null | fzf | while read img; do
                termux-open "$img"
            done
            ;;
        2)
            find /sdcard -type f \( -iname "*.mp4" -o -iname "*.avi" -o -iname "*.mkv" \) 2>/dev/null | fzf | while read video; do
                termux-open "$video"
            done
            ;;
        3)
            cmus
            ;;
        4)
            echo "Grabando (Ctrl+C para detener)..."
            termux-microphone-record -d 10 -f "$HOME/sound.mp3"
            ;;
        5)
            echo "Archivo origen:"
            src=$(fzf)
            echo "Formato destino (mp3, mp4, jpg...):"
            read fmt
            ffmpeg -i "$src" "converted.$fmt"
            ;;
        6)
            termux-camera-photo -c 0 "photo_$(date +%s).jpg"
            ;;
        0) menu ;;
    esac
}

# ========== MONITOR DEL SISTEMA ==========
menu_monitor() {
    while true; do
        clear
        echo -e "${B}╔════════════════════════════════════════╗${N}"
        echo -e "${B}║         📊 MONITOR DEL SISTEMA        ║${N}"
        echo -e "${B}╚════════════════════════════════════════╝${N}"
        echo ""
        
        # Información del dispositivo
        echo -e "${Y}📱 DISPOSITIVO:${N}"
        neofetch --stdout | head -5
        
        echo -e "\n${Y}💾 ALMACENAMIENTO:${N}"
        duf / /sdcard 2>/dev/null || df -h
        
        echo -e "\n${Y}📊 CPU/MEMORIA:${N}"
        top -n 1 -b | head -10
        
        echo -e "\n${Y}🌡️  TEMPERATURA:${N}"
        termux-battery-status | grep temperature
        
        echo -e "\n${Y}📶 RED:${N}"
        termux-wifi-connectioninfo 2>/dev/null | grep -E "ssid|rssi"
        
        echo -e "\n${Y}🔋 BATERÍA:${N}"
        termux-battery-status | grep -E "percentage|status"
        
        echo ""
        echo -e "${W}[1] Actualizar | [2] Procesos | [3] Gráfico | [0] Volver${N}"
        read -t 10 -n 1 key || key="1"
        
        case $key in
            2) htop ;;
            3) 
                echo "Gráfico de CPU (5s)..."
                for i in {1..5}; do
                    cpu=$(top -n 1 -b | grep "%Cpu" | awk '{print $2}')
                    bar=$(printf "%-${cpu}s" "█" | tr ' ' '█')
                    echo -e "[$bar] $cpu%"
                    sleep 1
                done
                read -p "Enter..."
                ;;
            0) break ;;
        esac
    done
}

# ========== TEMAS VISUALES ==========
menu_temas() {
    clear
    echo -e "${P}╔════════════════════════════════════════╗${N}"
    echo -e "${P}║         🎨 SELECCIONAR TEMA            ║${N}"
    echo -e "${P}╚════════════════════════════════════════╝${N}"
    echo ""
    echo -e "${W}Temas disponibles:${N}"
    echo "1) 🌿 Hacker Green"
    echo "2) 💜 Purple Dream"
    echo "3) 🌊 Ocean Blue"
    echo "4) 🟠 Retro Amber"
    echo "5) 🌃 Cyberpunk"
    echo "6) 🧛 Dracula"
    echo "7) ❄️ Nord"
    echo "8) 🏔️ Gruvbox"
    echo "9) ☀️ Solarized"
    echo "10) 🌈 Random"
    echo "11) 🎲 Cambiar cada día"
    echo "0) Volver"
    echo ""
    read -p "Selecciona tema: " tema_opt
    
    case $tema_opt in
        1) echo "hacker-green" > "$HOME/.current_theme" ;;
        2) echo "purple-dream" > "$HOME/.current_theme" ;;
        3) echo "ocean-blue" > "$HOME/.current_theme" ;;
        4) echo "retro-amber" > "$HOME/.current_theme" ;;
        5) echo "cyberpunk" > "$HOME/.current_theme" ;;
        6) echo "dracula" > "$HOME/.current_theme" ;;
        7) echo "nord" > "$HOME/.current_theme" ;;
        8) echo "gruvbox" > "$HOME/.current_theme" ;;
        9) echo "solarized" > "$HOME/.current_theme" ;;
        10) echo "random" > "$HOME/.current_theme" ;;
        11) echo "daily" > "$HOME/.current_theme" ;;
        0) menu ;;
    esac
    
    echo -e "${G}✅ Tema guardado. Reinicia Termux para aplicar.${N}"
    sleep 2
}

# ========== UTILIDADES ==========
menu_utilidades() {
    clear
    echo -e "${Y}╔════════════════════════════════════════╗${N}"
    echo -e "${Y}║         🔧 UTILIDADES                  ║${N}"
    echo -e "${Y}╚════════════════════════════════════════╝${N}"
    echo ""
    echo -e "${W}[1] Generar contraseña segura${N}"
    echo -e "${W}[2] Analizar red WiFi${N}"
    echo -e "${W}[3] Escanear puertos${N}"
    echo -e "${W}[4] Descargar video de YouTube${N}"
    echo -e "${W}[5] Extraer texto de imagen${N}"
    echo -e "${W}[6] Comprimir imágenes${N}"
    echo -e "${W}[7] Backup de configuraciones${N}"
    echo -e "${W}[8] Limpiar caché${N}"
    echo -e "${W}[0] Volver${N}"
    echo ""
    read -p "Opción: " opt
    
    case $opt in
        1)
            openssl rand -base64 32
            read -p "Enter..."
            ;;
        2)
            termux-wifi-scaninfo | jq '.'
            read -p "Enter..."
            ;;
        3)
            read -p "IP o dominio: " target
            nmap -F "$target"
            read -p "Enter..."
            ;;
        4)
            read -p "URL de YouTube: " url
            youtube-dl "$url"
            ;;
        5)
            read -p "Imagen: " img
            tesseract "$img" stdout
            read -p "Enter..."
            ;;
        6)
            find . -name "*.jpg" | while read img; do
                convert "$img" -resize 50% "small_$img"
            done
            ;;
        7)
            tar -czf "termux_backup_$(date +%Y%m%d).tar.gz" ~/.termux ~/.bashrc ~/.zshrc 2>/dev/null
            echo "✅ Backup creado"
            sleep 1
            ;;
        8)
            rm -rf ~/.cache/*
            echo "✅ Caché limpiado"
            sleep 1
            ;;
        0) menu ;;
    esac
}

# ========== RED ==========
menu_red() {
    clear
    echo -e "${C}╔════════════════════════════════════════╗${N}"
    echo -e "${C}║         🌐 HERRAMIENTAS DE RED         ║${N}"
    echo -e "${C}╚════════════════════════════════════════╝${N}"
    echo ""
    echo -e "${W}[1] Información WiFi${N}"
    echo -e "${W}[2] Escanear redes${N}"
    echo -e "${W}[3] Velocidad de internet${N}"
    echo -e "${W}[4] IP pública${N}"
    echo -e "${W}[5] Ping a servidor${N}"
    echo -e "${W}[6] Traceroute${N}"
    echo -e "${W}[7] Compartir archivo${N}"
    echo -e "${W}[8] Servidor HTTP local${N}"
    echo -e "${W}[0] Volver${N}"
    echo ""
    read -p "Opción: " opt
    
    case $opt in
        1) termux-wifi-connectioninfo | jq '.' ;;
        2) termux-wifi-scaninfo | jq '.[] | {ssid, capabilities, level}' ;;
        3) curl -s https://speedtest.net | grep "download" ;;
        4) curl -s ifconfig.me ;;
        5) 
            read -p "Host: " host
            ping -c 4 "$host"
            ;;
        6)
            read -p "Host: " host
            traceroute "$host"
            ;;
        7)
            file=$(fzf)
            termux-share "$file"
            ;;
        8)
            python -m http.server 8080 &
            echo "Servidor en http://localhost:8080"
            read -p "Enter para detener..."
            kill %1
            ;;
        0) menu ;;
    esac
    read -p "Enter..."
}

# ========== AYUDA ==========
mostrar_ayuda() {
    clear
    echo -e "${G}╔════════════════════════════════════════╗${N}"
    echo -e "${G}║         📚 AYUDA Y COMANDOS           ║${N}"
    echo -e "${G}╚════════════════════════════════════════╝${N}"
    echo ""
    echo -e "${Y}COMANDOS PRINCIPALES:${N}"
    echo "  menu     - Abre menú principal"
    echo "  nav      - Navegador visual"
    echo "  exp      - Explorador doble panel"
    echo "  buscar   - Busca archivos globalmente"
    echo "  copiar   - Copia archivos interactivo"
    echo "  mover    - Mueve archivos"
    echo "  borrar   - Mueve a papelera"
    echo "  papelera - Gestiona archivos borrados"
    echo "  tema     - Cambia tema visual"
    echo "  monitor  - Monitor del sistema"
    echo ""
    echo -e "${Y}ATAJOS DE TECLADO:${N}"
    echo "  Ctrl+C    - Cancelar"
    echo "  Ctrl+L    - Limpiar pantalla"
    echo "  Ctrl+R    - Buscar en historial"
    echo "  Tab       - Autocompletar"
    echo ""
    echo -e "${Y}DIRECTORIOS IMPORTANTES:${N}"
    echo "  ~/.trash        - Papelera de reciclaje"
    echo "  ~/.sounds       - Grabaciones de audio"
    echo "  /sdcard         - Almacenamiento interno"
    echo ""
    read -p "Enter para continuar..."
}

# ========== ALIAS Y FUNCIONES ==========
alias buscar='find /sdcard -type f 2>/dev/null | fzf --preview "bat --color=always {} 2>/dev/null"'
alias copiar='read -p "Origen: " src; read -p "Destino: " dst; cp -r "$src" "$dst"'
alias mover='read -p "Origen: " src; read -p "Destino: " dst; mv "$src" "$dst"'
alias borrar='read -p "Archivo: " file; mv "$file" ~/.trash/'
alias papelera='cd ~/.trash && ls -la'
alias tema='menu_temas'
alias monitor='menu_monitor'

# Historial de navegación
navhist() {
    if [ -f "$HIST_FILE" ]; then
        local dir=$(tac "$HIST_FILE" 2>/dev/null | awk '!seen[$0]++' | fzf)
        [ -n "$dir" ] && cd "$dir"
    fi
}

# Comprimir/Descomprimir
comprimir() {
    echo "Selecciona archivos:"
    files=$(fzf -m)
    if [ -n "$files" ]; then
        echo "1) ZIP  2) TAR.GZ"
        read -p "Formato: " fmt
        case $fmt in
            1) zip archive.zip $files ;;
            2) tar -czf archive.tar.gz $files ;;
        esac
    fi
}

# Abrir archivos según tipo
abrir_archivo() {
    case $(file -b --mime-type "$1") in
        image/*) termux-open "$1" ;;
        video/*) termux-open "$1" ;;
        audio/*) termux-open "$1" ;;
        text/*) bat "$1" ;;
        application/pdf) termux-open "$1" ;;
        *) termux-open "$1" 2>/dev/null || echo "No se puede abrir: $1" ;;
    esac
    read -p "Enter..."
}

# Si se ejecuta directamente, mostrar menú
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    menu
fi
EOF

# Crear archivo de colores
cat > "$HOME/.config/ultimate/colors.sh" << 'EOF'
# Colores para el tema actual
R='\033[0;31m'
G='\033[0;32m'
Y='\033[0;33m'
B='\033[0;34m'
P='\033[0;35m'
C='\033[0;36m'
W='\033[1;37m'
N='\033[0m'
EOF

# ========== CONFIGURAR BASH ==========
echo -e "${YELLOW}[🔧] Configurando bash...${NC}"

cat >> "$HOME/.bashrc" << 'EOF'

# ===== TERMUX GESTOR DE ARCHIVOS DG  MEGA PACK =====
source ~/.config/ultimate/ultimate.sh

# Alias avanzados
alias ls='eza -lah --icons'
alias ll='eza -l --icons'
alias la='eza -a --icons'
alias lt='eza --tree --icons --level=2'
alias cat='bat'
alias top='htop'
alias ..='cd ..'
alias ...='cd ../..'
alias home='cd ~'
alias sdcard='cd /sdcard'
alias edit='nano'
alias py='python'
alias ip='curl -s ifconfig.me'
alias wifi='termux-wifi-scaninfo'
alias battery='termux-battery-status'
alias matrix='cmatrix -b'
alias weather='curl wttr.in'
alias news='curl https://news.ycombinator.com | glow'
alias cheat='tldr'

# Funciones útiles
mkcd() { mkdir -p "$1" && cd "$1"; }
backup() { cp "$1" "$1.bak"; }
extract() { tar -xzf "$1"; }
download() { curl -O "$1"; }

# Historial mejorado
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth

# Prompt personalizado con tema
PROMPT_COMMAND='PS1="\[\033[01;32m\]\u@termux\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n└─ $ "'

# Mensaje de bienvenida
clear
echo ""
figlet -f digital "ULTIMATE" 2>/dev/null | lolcat 2>/dev/null
echo ""
echo -e "\033[0;35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;36m🔥 TERMUX GESTOR DE ARCHIVOS DG  🔥\033[0m"
echo -e "\033[0;35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;33m📌 Comandos rápidos:\033[0m"
echo -e "   \033[1;32mmenu\033[0m  - Menú principal"
echo -e "   \033[1;32mnav\033[0m   - Navegador visual"
echo -e "   \033[1;32mexp\033[0m   - Explorador doble panel"
echo -e "   \033[1;32mbuscar\033[0m - Buscador global"
echo -e "   \033[1;32mmatrix\033[0m - Modo Matrix"
echo -e "\033[0;35m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
EOF

# Crear archivo de instalación rápida
cat > "$HOME/install_rapido.sh" << 'EOF'
#!/bin/bash
echo "🚀 Instalando TERMUX GESTOR DE ARCHIVOS DG ..."
curl -sSL https://raw.githubusercontent.com/TU-USER/termux-ultimate/main/install.sh | bash
EOF
chmod +x "$HOME/install_rapido.sh"

# Marcar como instalado
date > "$HOME/.ultimate_installed"

# ========== FINAL ==========
clear
echo ""
figlet -f slant "LISTO" 2>/dev/null | lolcat 2>/dev/null || echo "✅ INSTALACIÓN COMPLETADA"
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║   ✅ TERMUX GESTOR DE ARCHIVOS DG  MEGA PACK INSTALADO           ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}TEMA SELECCIONADO:${NC} ${YELLOW}$TEMA${NC}"
echo ""
echo -e "${WHITE}📋 COMANDOS PRINCIPALES:${NC}"
echo -e "  ${GREEN}menu${NC}     → Menú principal interactivo"
echo -e "  ${GREEN}nav${NC}      → Navegador visual con preview"
echo -e "  ${GREEN}exp${NC}      → Explorador doble panel"
echo -e "  ${GREEN}buscar${NC}   → Buscador global en teléfono"
echo -e "  ${GREEN}monitor${NC}  → Monitor del sistema"
echo -e "  ${GREEN}wifi${NC}     → Escanear redes WiFi"
echo -e "  ${GREEN}matrix${NC}   → Modo Matrix"
echo -e "  ${GREEN}weather${NC}  → Clima actual"
echo ""
echo -e "${YELLOW}🎯 PARA EMPEZAR:${NC}"
echo -e "  ${WHITE}1.${NC} Cierra y abre Termux (o ejecuta 'bash')"
echo -e "  ${WHITE}2.${NC} Escribe ${GREEN}menu${NC} para el menú principal"
echo -e "  ${WHITE}3.${NC} Escribe ${GREEN}nav${NC} para navegar archivos"
echo ""
echo -e "${PURPLE}📦 INSTALACIÓN RÁPIDA PARA COMPARTIR:${NC}"
echo -e "  ${CYAN}curl -sSL https://bit.ly/termux-ultimate | bash${NC}"
echo ""
echo -e "${GREEN}🔥 DISFRUTA TU TERMUX GESTOR DE ARCHIVOS DG ! 🔥${NC}"
