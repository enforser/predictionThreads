#!Perl/bin/perl

#returns a number that is a valid option on the main menu
sub getCommand {
	$command = -1;
	while($command > 3 || $command < 0) {
		chomp($command = <>);
	}
	return $command;
}

sub printMenu {
	print "\n    Ottawa Senators Prediction Thread Tools\n\n";
	print "      (0) Exit\n";		
	print "      (1) See Current Results\n";
	print "      (2) Import New Results\n";
	print "      (3) Update Correct Answers\n";
}
while(1) {
	printMenu();
	$command = getCommand();

	if ($command == 0) {
		exit();
	}
	elsif ($command == 1) {
		print "\n\n    CURRENT RESULTS:";
		print "\n\n      Username                                    Score";
		print "\n\n";
	}
	elsif ($command == 2) {
		print "\n\n    Please enter the name of the document to import";
		print "\n\n";
	}
	elsif ($command == 3) {
		print "\n\n    Haha";
		print "\n\n";
	}
}

printMenu();