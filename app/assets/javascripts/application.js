// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function() {

    $("#tweet-post-btn").on('click', function(evt){
        evt.preventDefault();

        var tweet_text = $("#tweet-textarea").val();

        $.ajax({
            type: 'POST',
            url: '/tweets/create',
            data: { tweet_text: tweet_text },
            success: function(res){
                console.log("Success posting tweet: ", res);
            },
            error: function(err){
                console.log("Error posting tweet: ", err);
            }
        });
    });



    var MAX_TWEETS_DISPLAYED = 50;

    function getTweetTpl(cb){
        $.ajax({
            type: 'GET',
            url: '/tweets/get_tpl',
            dataType: 'text',
            success: function(tplStr){
                //console.log("Found tpl string: ", tplStr);
                cb(null, tplStr);
            },
            error: cb
        });
    }

    getTweetTpl(function(err, tweetTplStr){
        if(err){
            console.log("Error fetching tweet template: ", err);
            return false;
        }

        var counter = 0;
        var source = new EventSource('/socket'), message;
        source.addEventListener('ping', function(e){
            console.log("Received ping from SSE");
        });
        source.addEventListener('tweet', function (e) {
            console.log("Received event:", e);
            var tweet = JSON.parse(e.data);
            console.log("Tweet: ", tweet);

            tweet.timeago = moment( tweet.created_at.replace('UTC', 'Z') ).fromNow()

            $("#tweet-list").prepend("<li>" + _.template(tweetTplStr, { tweet : tweet }) + "</li>");

            if(counter > MAX_TWEETS_DISPLAYED) $("#tweet-list li:last-child").remove()
                else counter++;

        });
    });
});
