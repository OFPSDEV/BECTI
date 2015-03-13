while {! CTI_GameOver && alive  _this } do {
	_this call AN_Reconfigure;
	sleep 10+random(15);
};