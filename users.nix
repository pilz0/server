{ ... }:
{
  users.users = {
    marie = {

      isNormalUser = true;
      description = "marie";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIBTGgUYUsIAtcbZBqk5Mq0LH2T5KGFjdjAgNIwUf+/LBAAAABHNzaDo= pilz@framewok"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP6weqYi/f7nQzsCr11NVz/7cdmpSq7sU1N+Ag5jM45S daniel@underdesk"
      ];
    };
    # Jule
    pizzaladen.isNormalUser = true;
    pizzaladen.description = "pizzaladen";
    pizzaladen.createHome = true;
    pizzaladen.home = "/home/pizzaladen";
    pizzaladen.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINW02E19w2YUO7d82WDHyMqfyUdIDCgjblwPJvgc1wzF pizzaladen@pizzaladen-HP-EliteBook-840-G1"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC6VDJ9roxToSC8qT+zawLauEDWnC2+W/b/jw19Wiq+6ug+Ey725sxl62nMxI1INpUCkYUSbXlziWA1Ml0XT/jgDZ4CPbKq5yAoziY6UvXZkRDTuhXLn4UViUiEqn9Y2X9t5CtU7TON8vp7SIIGWlJXz1FF9d/05KNEYBTyNY7HW+m4JCZ8CZ8rIgdZ25jaOIAMtiOLiiva7l3bgFYopOnftSlvlndvymaLGv67uraTPRXHaT5oLCa/GkiSC1jwhWIQ2LmD5YXAoUUYpODBBjXNOE6ULkq2xO7yJdc39MeqkRcD6fwCXjWcY9GAn2BGJWO3Iss2em6ObaKMvD4QiGzK36e43zj80YTuUh5+pSn4tqheKkl73bW2Savw/7HZ8sI21CjoZYSqoKTXhxYDKz7YycwAkjcN/dai6wzTt2mbZ4plJVsaFo/b42tkYUGVnvbFGIiBHv3ALHgpyzsqkP3AiEqVvZFb2OYa/5U32e5PVszBrIML9pgWOCZyumMtqjw4FMPtf3bGcSKG54T8QR6uSuL5YVakQiVZOxBRBDv9TVGjkrfhh8U/DxVlV0HJ66ExY3VgMZDcqnOuexoun6HRr0KG7xil3YBlmJnGkyBeemeJ/CV+nBRelPYCZ/+X9C3JEIi4ACYYxOqOGwZ8JGtrDroFwdBTtI6LD6mzgQ9Dew== jule@DESKTOP-ABQ1DJO"
    ];

  };
}
