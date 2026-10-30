#!/data/data/com.termux/files/usr/bin/bash

set -e

echo "===== TERMUX AUTO SETUP ====="

echo "[1/6] Actualizando..."
pkg update -y
pkg upgrade -y

echo "[2/6] Instalando paquetes..."
pkg install -y openssh termux-api procps

echo "[3/6] Creando Termux:Boot..."
mkdir -p ~/.termux/boot

echo "[4/6] Creando script SSH..."
cat > ~/.termux/boot/sshd.sh <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
sleep 15
while true; do
    pgrep -x sshd >/dev/null || sshd
    sleep 60
done
EOF

chmod +x ~/.termux/boot/sshd.sh

echo "[5/6] Solicitando almacenamiento..."
termux-setup-storage || true

echo "[6/6] Iniciando SSH..."
sshd || true

echo ""
echo "===== INSTALACION COMPLETADA ====="
echo "Puerto SSH: 8022"
echo "Configura tu contraseña con: passwd"
echo "Instala Termux:Boot y Termux:API."
echo "Abre Termux:Boot una vez."
