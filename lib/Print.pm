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
	print "Enter the year of the season to see their results\n";
	chomp ($year = <>);
	print "Enter the name of the month";
	chomp ($month = <>);
	print "    CURRENT RESULTS\n";
	print "    ---------------\n\n";
}
1;