// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .



J = {

    init: function()
    {
        J.session();
        J.event();
        J.tag();
        J.genre();
        J.comments();
    },

    session: function() {
        //registration
        $(document).off("click", ".sys-reg-user");
        $(document).on("click", ".sys-reg-user", function() {
            var form = $(document).find("form");
            API.registration(form.serialize(), function(code) {
                alert(code.reg);
            }, function(code){
                alert(code);
            });

        });


        //facebook
        //https://www.facebook.com/dialog/oauth?client_id=750901265022718&redirect_uri=http%3A%2F%2Ff74a6f62.ngrok.io%2Fusers%2Fauth%2Ffacebook%2Fcallback&response_type=code&scope=email&state=c5a9763feae3e272b3f6c15b0ebc8af19ee423f627ecae6a
        //http://f74a6f62.ngrok.io/users/auth/facebook/callback?code=AQD65zGkJD83i_wCZo7N0pkQQIfcPCdqEj_HQxIcr1L4rzT7lbSh_Wx3nGxhK_d3AfHfcaXvbNJzeFFDswIH3ILo-6hr6wHM7zTMe4UdFurKOB4DQyC88dXsAAZep_1oxe9AOsH21_6FrDiK84s7JJ6xEk_rXIr7yH-JYQhgPM12zZ3-StDICkDqz4RUPEQLtNx4y3B0g_ADRtYiLH1nOAxi1pFHK8b08XwJAkUwy3P0bne5KqJqfQR09g-c0-rIBBeVumMl8i-NQ8zHZKoN4rhqemwD7E-mffmiFDeSXpvpMmSD3uSyMsIA-T1UqNEfdndyd_iUXr35m2muuSiF36yw&state=66353443bcf02ee2c21a6d8121677064f894e2da08c992d0#_=_
        // request.env["omniauth.auth"]

    },

    event: function()
    {
        // add event
        $(document).off("click", ".sys-add-event");
        $(document).on("click", ".sys-add-event", function() {
            var form = $(document).find("form");
            API.addEvent(form.serialize(), function(code) {
                alert(code.save_success);
            }, function(code){
                alert(code);
            });
        });

        //getEventsByTagWithCount


    },

    tag: function()
    {
        // add tag
        $(document).off("click", ".sys-add-tag");
        $(document).on("click", ".sys-add-tag", function() {
            var form = $(document).find("form");
            API.addTag(form.serialize(), function(code) {
                alert(code.save_success);
            }, function(code) {
                alert(code);
            });
        });
    },

    genre: function()
    {
        // add genre
        $(document).off("click", ".sys-add-genre_tag");
        $(document).on("click", ".sys-add-genre_tag", function() {
            var form = $(document).find("form");
            API.addGenre(form.serialize(), function(code) {
                alert(code.save_success);
            }, function(code) {
                alert(code);
            });
        });
    },

    comments: function()
    {
        // add comments
        $(document).off("click", ".sys-add-comment");
        $(document).on("click", ".sys-add-comment", function() {
            var form = $(document).find("form");
            API.addComment(form.serialize(), function(code) {
                alert(code.save_success);
            }, function(code) {
                alert(code);
            });
        });
    }
};


$( document ).ready(function() {
    J.init();
});


//
//window.fbAsyncInit = function() {
//    FB.init({
//        appId      : '750901265022718',
//        xfbml      : true,
//        version    : 'v2.3'
//    });
//};
//
//(function(d, s, id){
//    var js, fjs = d.getElementsByTagName(s)[0];
//    if (d.getElementById(id)) {return;}
//    js = d.createElement(s); js.id = id;
//    js.src = "//connect.facebook.net/en_US/sdk.js";
//    fjs.parentNode.insertBefore(js, fjs);
//}(document, 'script', 'facebook-jssdk'));
