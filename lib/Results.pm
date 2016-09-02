package Results;

#These functions serve the purpose of managing and compiling the
#logs and scores

#add the data to the game log
#asks user which file to add logs to
#assumes file is in 'Logs' and it ends with '.log'
#if file does not exist it creates the file

sub logData {
	print "\n\n";
	my (@data) = @_;
	print "Which file would you like to log to?";
	print "    *Follow the format DDMMYY for the game*\n      ";
	chomp ($file = <>);
	my $filename = 'logs/' . $file . '.log';
	open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";
	foreach my $str (@data) {
		$str = localtime . " " . $str;
		say $fh $str;
	}
	close $fh;
	print "\n\n";
}

#Add the scores
sub compileScores {
	#get the file names
	print "\n\n";
	print "\nWhich game should scores be updated for?";
	print "    *Follow the format DDMMYY for the game*\n\n      ";
	chomp ($gameFilename = <>);
	print "\nWhich season are we answering for?";
	print "    *Follow the format YYYY for the start of season*\n\n      ";
	chomp ($year = <>);
	print "\nWhich month should scores be updated for?";
	print "    *Type month in capital letters\n\n      ";
	chomp ($month = <>);
	print "\n\n";
	
	#Get the data in game log and score sheets
	$gameFilename = 'logs/' . $gameFilename . '.log';
	$year = 'scores/year/' . $year . '.log';
	$month = 'scores/month/' . $month . '.log';
	$logContent = getFile($gameFilename);
	$yearScores = getFile($year);
	$monthScores = getFile($month);
	
	@answers = answerKey();
	@usersScores;
	my @logContent = split /\n/, $logContent;
	for ($count = 0; $count < @logContent; $count++) {
		@temp = split /\s+/, @logContent[$count];
		print @temp;
		@tempAnswers = (@temp[7], @temp[8], @temp[9], @temp[10]);
		@tempUser;
		@tempUser[0] = @temp[5];
		@tempUser[1] = 0;
		for ($index = 0; $index < @tempAnswers; $index++) {
			if (@answers[$index] eq @tempAnswers[$index])
			{
				@tempUser[1]++;
			}
		}
		push @usersScores, [@tempUser];
	}
	updateScores(\@usersScores, $year, "year");
	updateScores(\@usersScores, $month, "month");
}

sub updateScores {
	@scores = @{$_[0]};
	$document = @_[1];
	$type = @_[2];
	my ($str);
	$fullDocument = getFile($document);
	@currScores = split /\n/, $fullDocument;
	#cycle through scores for each user
	for ($count = 0; $count < @scores; $count++) {
		#see if user has played before
		if (checkUser(@scores[$count]->[0], $fullDocument)) {
			print "\n" . @scores[$count]->[0] . " has played before - updating score.\n";
			#upgrade users score
			#cycle through past users
			for ($index = 0; $index < @currScores; $index++) {
				#check when we get to the relevant user
				if (checkUser(@scores[$count]->[0], @currScores[$index])) {
					@tempUser = split / /, @currScores[$index];
					@tempUser[1] = int(@tempUser[1]) + @scores[$count]->[1];
					$str = @tempUser[0] . " " . @tempUser[1] . "\n" . $str;
				}
			}
		}
		else {
			print "\nAdding new user" . @scores[$count]->[0] . " to the log\n";
			$str = @scores[$count]->[0] . " " . @scores[$count]->[1] . "\n" . $str;
		}
		#$str = @scores[$count]->[0] . " " . @scores[$count]->[1] . "\n" . $str;
	}
	#add all players who have played before but didn't play the current round
	for ($count = 0; $count < @currScores; $count++) {
		@tempUser = split / /, @currScores[$count];
		if (checkUser(@tempUser[0], $str) == 0) {
			$str = @tempUser[0] . " " . @tempUser[1] . "\n" . $str;
		}
	}
	writeFile($document, $type, $str);
}

sub checkUser {
	my ($substr) = @_[0];
	my ($str) = @_[1];
	if (index($str, $substr) != -1) {
		return 1;
	}
	else {
		return 0;
	}
}

sub writeFile {
	my ($filename) = @_[0];
	my ($type) = @_[1];
	my ($str) = @_[2];
	archiveFile($filename, $type);
	open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";
	say $fh $str;
	close $fh;
}

sub archiveFile {
	my ($filename) = @_[0];
	my ($type) = @_[1];
	File::Copy::copy($filename, "scores/archives/" . localtime . $type . ".log") or die "cannot copy file";
	unlink $filename or die "Error: Unlink failed.";
}

sub getFile {
	print "\n\n";
	my ($filename) = @_;
	my $content;
    open(my $fh, '<', $filename) or die "cannot open file $filename";
    {
        local $/;
        $content = <$fh>;
    }
    close($fh);
	print "...... Found $filename ......\n";
	return $content;
}

#Get Game Answer Key
sub answerKey {
	print "\n\n";
	@answers;
	print "\n    CREATING ANSWER KEY\n";
	for ($count = 1; $count <= 4; $count++) {
		print "\n      Input Answer #$count\n\n		";
		chomp ($answer = <>);
		push @answers, $answer;
	}
	print "\n\n";
	return @answers;
}

1;