#!Perl/bin/perl

use Reddit::Client;

my $client_id       = "KAgssi0vqHC1Vw";
my $secret          = "secret";
my $username        = "OttawaSenatorsBot";
my $password        = "password";


# Create a Reddit::Client object and authorize in one step
my $reddit = new Reddit::Client(
	user_agent      => 'Ottawa Senators Prediction Thread',
	client_id       => $client_id,
	secret          => $secret,
	username        => $username,
	password        => $password,
);

# Get comments from a specific post

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
	$str = $comment->{body};
	$str =~ s/^\s+|\s+$//g;
	my @answers = split / /, $str;
	#provide checking equations on each character
	if (@answers > 4 || @answers < 4) {
		$comment->reply('This is invalid.');
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
	my ($reddit) = @_;
	$posts = $reddit->fetch_links(subreddit=>'test', limit=>'100');
	$post;
	foreach my $currpost (@$posts) {
		if ($currpost->{author} eq $username) {
			return $currpost;
		}
	}
}

#add the data to the game log
#asks user which file to add logs to
#assumes file is in 'Logs' and it ends with '.log'
#if file does not exist it creates the file
sub logData {
	my (@data) = @_;
	print "Which file would you like to log to?";
	print "    *Follow the format DDMMYY for the game*\n      ";
	chomp ($file = <>);
	my $filename = 'Logs/' . $file . '.log';
	open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";
	foreach my $str (@data) {
		$str = localtime . " " . $str;
		say $fh $str;
	}
	close $fh;
}

#printMainMenu
sub printMenu {
	print "\nWelcome to the management system for the Ottawa";
	print " Senators Prediction Threads!\n\n";
	print "    (1) Get data from most recent post by /u/OttawaSenatorsBot\n";
	print "    (2) Update the scores for users\n";
	print "    (3) Post a new thread\n";
	print "    (4) View current results\n";
	print "    (0) Exit\n";
}

#UIMANAGER
while (1) {
	$command = -1;
	printMenu();
	while ($command < 0 || $command > 4) {
		chomp ($command = <>);
	}
	if ($command == 1) {
		$post = getPost($reddit);
		@data = getData($post);
		logData(@data);
	}
	elsif ($command == 2) {
		
	}
	elsif ($command == 3) {
		
	}
	elsif ($command == 4) {
		
	}
	elsif ($command == 0) {
		exit();
	}
}
