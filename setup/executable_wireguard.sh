sudo cp ~/Documents/zubeir.conf /etc/wireguard/zubeir.conf
sudo chmod 600 /etc/wireguard/zubeir.conf
sudo wg-quick up zubeir
sudo systemctl enable --now wg-quick@zubeir
