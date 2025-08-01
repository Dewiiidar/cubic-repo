﻿var chatboxManager = function () {
    var a = function (a) {
        $.extend(chatbox_config, a)
    },
        b = function (a) { },
        c = function () {
            return (chatbox_config.width + chatbox_config.gap) * showList.length
        },
        d = function (a) {
            var b = showList.indexOf(a);
            if (-1 != b) {
                showList.splice(b, 1), diff = chatbox_config.width + chatbox_config.gap;
                for (var c = b; c < showList.length; c++) offset = $("#" + showList[c]).chatbox("option", "offset"), $("#" + showList[c]).chatbox("option", "offset", offset - diff)
            } else alert("NOTE: Id missing from array: " + a)
        },
        e = function (a, b, e) {
            var g = showList.indexOf(a),
                h = boxList.indexOf(a);
            if (-1 != g);
            else if (-1 != h) {
                $("#" + a).chatbox("option", "offset", c());
                var i = $("#" + a).chatbox("option", "boxManager");
                i.toggleBox(), showList.push(a)
            } else {
                var j = document.createElement("div");
                j.setAttribute("id", a), $(j).chatbox({
                    "id": a,
                    "user": b,
                    "title": '<i title="' + b.status + '"></i>' + b.first_name + " " + b.last_name,
                    "hidden": !1,
                    "offset": c(),
                    "width": chatbox_config.width,
                    "status": b.status,
                    "alertmsg": b.alertmsg,
                    "alertshow": b.alertshow,
                    "messageSent": f,
                    "boxClosed": d
                }), boxList.push(a), showList.push(a), nameList.push(b.first_name)
            }
        },
        f = function (a, b, c) {
            $("#chatlog").doesExist() && $("#chatlog").append("You said to <b>" + b.first_name + " " + b.last_name + ":</b> " + c + "<br/>").effect("highlight", {}, 500), $("#" + a).chatbox("option", "boxManager").addMsg("Me", c)
        };
    return {
        "init": a,
        "addBox": e,
        "delBox": b,
        "dispatch": f
    }
}();
$("a[data-chat-id]:not(.offline)").click(function (a, b) {
    var c = $(this),
        d = c.attr("data-chat-id"),
        e = c.attr("data-chat-fname"),
        f = c.attr("data-chat-lname"),
        g = c.attr("data-chat-status") || "online",
        h = c.attr("data-chat-alertmsg"),
        i = c.attr("data-chat-alertshow") || !1;
    chatboxManager.addBox(d, {
        "title": "username" + d,
        "first_name": e,
        "last_name": f,
        "status": g,
        "alertmsg": h,
        "alertshow": i
    }), a.preventDefault()
});