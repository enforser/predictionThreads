#!Perl/bin/perl

BEGIN { push @INC, 'lib' }

use Reddit::Client;
use File::Copy "cp";
use Comm;
use Print;
use Results;

my $client_id       = "KAgssi0vqHC1Vw";
my $secret          = "qS0uwpSXhz4L4WLb7WXzUFlXww0";
my $username        = "OttawaSenatorsBot";
my $password        = "beyblade";

# Create a Reddit::Client object and authorize in one step
my $reddit = new Reddit::Client(
	user_agent      => 'Ottawa Senators Prediction Thread',
	client_id       => $client_id,
	secret          => $secret,
	username        => $username,
	password        => $password,
);


#UIMANAGER
while (1) {
	$command = -1;
	Print::printMenu();
	while ($command < 0 || $command > 4) {
		chomp ($command = <>);
	}
	if ($command == 1) {
		@data = Comm::getPost($reddit);
		Results::logData(@data);
	}
	elsif ($command == 2) {
		Results::compileScores();
	}
	elsif ($command == 3) {
		Comm::makePost($reddit);
	}
	elsif ($command == 4) {
		Print::printResults();
	}
	elsif ($command == 0) {
		exit();
	}
}
