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

1;