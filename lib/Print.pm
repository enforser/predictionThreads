package Print;

# This is where I will store functions meant to print to the console

#printMainMenu
sub printMenu {
	print "\n\n";
	print "\nMain menu for prediction thread management!\n\n";
	print "    (1) Get data from most recent post by /u/OttawaSenatorsBot\n";
	print "    (2) Update the scores for users\n";
	print "    (3) Post a new thread\n";
	print "    (4) View current results\n";
	print "    (0) Exit\n";
	print "\n\n";
}

sub space {
	print "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";
}

sub printResults {
	space();
	print "\n\n  Would you like to see monthly or yearly results? (m/y)\n\n  ";
	chomp ($choice = <>);
	if ($choice eq "m") {
		print "\n		Enter the name of the month\n\n  ";
		chomp ($month = <>);
		open ($file, "scores/month/" . uc($month) . ".log");
	}
	else {
		print "\n  Enter the year of the season to see their results\n\n  ";
		chomp ($year = <>);
		print "\n\n";
		open ($file, "scores/year/$year.log");
	}
	print     "\n           RESULTS";
	print     "\n           -------\n";
	while (my $line = <$file>) {
		print "\n      " . $line;
	}
}
1;