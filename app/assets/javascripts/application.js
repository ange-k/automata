// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets

function send_correct_category(obj, tw_id, tr_index, url) {
    var index = obj.selectedIndex;
    var value = obj.options[index].value;
    var data = {
        tweet_id: tw_id,
        category_id: value,
        index: tr_index
    };
    $.post({
        url:  url,
        data: JSON.stringify(data),
        contentType: 'application/json',
        dataType: "json"
    }).done(function(data, textStatus, jqXHR){
        console.log(data);
        var id = '#tr-' + tr_index + '-' + tw_id;
        $(id).replaceWith(data.html);
        // 成功の場合の処理
    }).fail(function(jqXHR, textStatus, errorThrown){
        // エラーの場合処理
    });
}