package Comm;

#get comments from the post
#returns an array of the comments with username at beginning
sub getData{
	my ($post) = @_;
	$postID = $post->{name};
	$comments = $post->comments();
	$count = 0;
	@array;
	foreach my $currcomm (@$comments) {
		if (checkComment($currcomm)) {
			$str = $currcomm->{body};
			$str =~ s/^\s+|\s+$//g;
			$str = $currcomm->{author} . " " . $currcomm->{created} . " " . $str;
			@array[$count] = $str;
			$count = $count + 1;
		}
		#$currcomm->reply(text=>'this is test comment');
	}
	return @array;
}

#Check to make sure answers are valid
#Replies to comment if invalid
sub checkComment {
	my ($comment) = @_;
	$reply = "Oops, I wasn't capable of logging your comment due to an error in the formatting. Please ensure that in future threads you utilize the guidelines provided.\n\n";
	$reply = $reply . "This comment will work as a flag for my owner to record your answers manually.\n\n";
	$reply = $reply . "----------------------------------------------\n\n";
	$reply . $reply . "*I am a bot. If you have any issues message my owner /u/mandm4s*";
	$str = $comment->{body};
	$str =~ s/^\s+|\s+$//g;
	my @answers = split / /, $str;
	#provide checking equations on each character
	if (@answers > 4 || @answers < 4) {
		$comment->reply($reply);
		return 0;
	}
	else {
		return 1;
	}
}

#get the most recent post by the user running the script
#saves it in variable "post"
#returns a Reddit::Client::Link object
sub getPost {
	print "\n\n";
	print "\n\n  .....Please wait while post data is being recovered..... \n\n";
	print "\n\n";
	my ($reddit) = @_;
	$posts = $reddit->fetch_links(subreddit=>'test', limit=>'1000');
	$post;
	foreach my $currpost (@$posts) {
		if ($currpost->{author} eq 'OttawaSenatorsBot') {
			return getData($currpost);
		}
	}
}

sub makePost {
	my ($reddit) = @_;
	
	print "\n\n";
	print "\n\n  Who is the home team?\n    ";
	chomp ($home = <>);
	print "\n\n  Who is the away team?\n    ";
	chomp ($away = <>);
	print "\n\n  What is the date of the game? (DD MMM)\n    ";
	chomp ($date = <>);
	print "\n\n  What is the game number?\n    ";
	chomp ($number = <>);
	print "\n\n  What is question #1?\n    ";
	chomp ($questionOne = <>);
	print "\n\n  What is question #2?\n    ";
	chomp ($questionTwo = <>);
	print "\n\n  What is question #3?\n    ";
	chomp ($questionThree = <>);
	print "\n\n  What is question #4?\n    ";
	chomp ($questionFour = <>);
	
	$title = "Prediction Thread #$number: $away at $home - $date";
	
	$body = "#Welcome to Prediction Thread #$number!\n\n";
	$body = $body . "##$date - $away at $home\n\n";
	$body = $body . "----------------------------------------------\n\n";
	$body = $body . "**Question #1:** $questionOne\n\n";
	$body = $body . "**Question #2:** $questionTwo\n\n";
	$body = $body . "**Question #3:** $questionThree\n\n";
	$body = $body . "**Question #4:** $questionFour\n\n";
	$body = $body . "----------------------------------------------\n\n";
	$body = $body . "###Rules and Guidelines\n\n";
	$body = $body . "Your answer should look like the following:\n\n";
	$body = $body . "    answerOne answerTwo answerThree answerFour\n\n";
	$body = $body . "Please note that the answer has an **identical number of words as questions**, with **one space** between each answer and **no spacing on either side**.\n\n";
	$body = $body . "Please record your answers in the same order that the questions are listed.\n\n";
	$body = $body . "###Please follow the guidelines provided to post your answer. I am a bot, so I have a hard time understanding any comment that does not follow the structure specified.\n\n";
	$body = $body . "----------------------------------------------\n\n";
	$body = $body . "*I am a bot. If you have any issues or concerns message my creator /u/mandm4s*";
	
	$reddit->submit_text(subreddit=>'test', title=>$title, text=>$body);
}

1;