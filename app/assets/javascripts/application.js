// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require jquery.turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require marked
//= require moment
//= require moment/zh-cn
//= require emojify.min
//= require d3
//= require cal-heatmap
// = require_tree .

function log(str){
    console.log(str)
}

$(function(){
    
    window._app_ = {
        
        init: function(){
            self = this
            this.siteBootUp();
            // this.initNotificationsCount();
        },
        siteBootUp: function(){
            this.refresh_moment();
            this.initEmoji();
            this.initScrollToTop();
            // this.initEditorPreview();
            // this.initHeightLight();
            // this.initReplyOnPressKey();
            // this.initDeleteForm();
            // this.initInlineAttach();
            // this.snowing();
            // this.forceImageDataType();
        },
        /**
         * Scroll to top in one click.
         */
        initScrollToTop: function(){
            $.scrollUp.init();
        },
        refresh_moment: function(){
            $('.timeago').each(function(){
                var time_str = $(this).text();
                if(moment(time_str, "YYYY-MM-DD HH:mm:ss Z", true).isValid()) {
                    $(this).text(moment(time_str).fromNow());
                }
            });
            if (window.refresh_moment_timer) {
                clearTimeout(window.refresh_moment_timer)    
            }
            window.refresh_moment_timer=setTimeout('self.refresh_moment()', 15000);
            log('refresh_moment')
        },
        initEmoji: function(){
            emojify.setConfig({
                img_dir : Settings.cdn_domain+'/images/emojis',
                ignored_tags : {
                    'SCRIPT'  : 1,
                    'TEXTAREA': 1,
                    'A'       : 1,
                    'PRE'     : 1,
                    'CODE'    : 1
                }
            });
            emojify.run();

            $('#body_original').textcomplete([
                { // emoji strategy
                    match: /\B:([\-+\w]*)$/,
                    search: function (term, callback) {
                        callback($.map(emojies, function (emoji) {
                            return emoji.indexOf(term) === 0 ? emoji : null;
                        }));
                    },
                    template: function (value) {
                        return '<img src="'+Settings.cdn_domain+'/images/emojis/' + value + '.png"></img>' + value;
                    },
                    replace: function (value) {
                        return ':' + value + ': ';
                    },
                    index: 1,
                    maxCount: 5
                }
            ]);
        },
      }

      _app_.init();
      var action = $('body').data('action')
      if (action == 'topics@show'||action == 'topics@new'||action=='topics@edit') {
        _topic_.init();
      }
})

