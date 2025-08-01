﻿! function (a) {
    a.widget("ui.chatbox", {
        "options": {
            "id": null,
            "title": null,
            "user": null,
            "hidden": !1,
            "offset": 0,
            "width": 300,
            "status": "online",
            "alertmsg": null,
            "alertshow": null,
            "messageSent": function (a, b, c) {
                this.boxManager.addMsg(b.first_name, c)
            },
            "boxClosed": function (a) { },
            "boxManager": {
                "init": function (a) {
                    this.elem = a
                },
                "addMsg": function (b, c) {
                    var d = this,
                        e = d.elem.uiChatboxLog,
                        f = document.createElement("div");
                    e.append(f), a(f).hide();
                    var g = !1;
                    if (b) {
                        var h = document.createElement("b");
                        a(h).text(b + ": "), f.appendChild(h)
                    } else g = !0;
                    var i = document.createElement(g ? "i" : "span");
                    a(i).text(c), f.appendChild(i), a(f).addClass("ui-chatbox-msg"), a(f).css("maxWidth", a(e).width()), a(f).fadeIn(), a(f).find("span").emoticonize(), d._scrollToBottom(), d.elem.uiChatboxTitlebar.hasClass("ui-state-focus") || d.highlightLock || (d.highlightLock = !0, d.highlightBox())
                },
                "highlightBox": function () {
                    var a = this;
                    a.elem.uiChatboxTitlebar.effect("highlight", {}, 300), a.elem.uiChatbox.effect("bounce", {
                        "times": 2
                    }, 300, function () {
                        a.highlightLock = !1, a._scrollToBottom()
                    })
                },
                "toggleBox": function () {
                    this.elem.uiChatbox.toggle()
                },
                "_scrollToBottom": function () {
                    var a = this.elem.uiChatboxLog;
                    a.scrollTop(a.get(0).scrollHeight)
                }
            }
        },
        "toggleContent": function (a) {
            this.uiChatboxContent.toggle(), this.uiChatboxContent.is(":visible") && this.uiChatboxInputBox.focus()
        },
        "widget": function () {
            return this.uiChatbox
        },
        "_create": function () {
            var b = this,
                c = b.options,
                d = c.title || "No Title",
                e = (b.uiChatbox = a("<div></div>")).appendTo(document.body).addClass("ui-widget ui-chatbox").attr("outline", 0).focusin(function () {
                    b.uiChatboxTitlebar.addClass("ui-state-focus")
                }).focusout(function () {
                    b.uiChatboxTitlebar.removeClass("ui-state-focus")
                }),
                f = (b.uiChatboxTitlebar = a("<div></div>")).addClass("ui-widget-header ui-chatbox-titlebar " + b.options.status + " ui-dialog-header").click(function (a) {
                    b.toggleContent(a)
                }).appendTo(e),
                g = ((b.uiChatboxTitle = a("<span></span>")).html(d).appendTo(f), (b.uiChatboxTitlebarClose = a('<a href="#" rel="tooltip" data-placement="top" data-original-title="Hide"></a>')).addClass("ui-chatbox-icon ").attr("role", "button").hover(function () {
                    g.addClass("ui-state-hover")
                }, function () {
                    g.removeClass("ui-state-hover")
                }).click(function (a) {
                    return e.hide(), b.options.boxClosed(b.options.id), !1
                }).appendTo(f)),
                h = (a("<i></i>").addClass("fa fa-times").appendTo(g), (b.uiChatboxTitlebarMinimize = a('<a href="#" rel="tooltip" data-placement="top" data-original-title="Minimize"></a>')).addClass("ui-chatbox-icon").attr("role", "button").hover(function () {
                    h.addClass("ui-state-hover")
                }, function () {
                    h.removeClass("ui-state-hover")
                }).click(function (a) {
                    return b.toggleContent(a), !1
                }).appendTo(f)),
                i = (a("<i></i>").addClass("fa fa-minus").appendTo(h), (b.uiChatboxContent = a('<div class="' + b.options.alertshow + '"><span class="alert-msg">' + b.options.alertmsg + "</span></div>")).addClass("ui-widget-content ui-chatbox-content ").appendTo(e)),
                j = ((b.uiChatboxLog = b.element).addClass("ui-widget-content ui-chatbox-log custom-scroll").appendTo(i), (b.uiChatboxInput = a("<div></div>")).addClass("ui-widget-content ui-chatbox-input").click(function (a) { }).appendTo(i)),
                k = (b.uiChatboxInputBox = a("<textarea data-id='" + d + "'></textarea>")).addClass("ui-widget-content ui-chatbox-input-box ").appendTo(j).keydown(function (c) {
                    return c.keyCode && c.keyCode == a.ui.keyCode.ENTER ? (msg = a.trim(a(this).val()), msg.length > 0 && b.options.messageSent(b.options.id, b.options.user, msg), a(this).val(""), !1) : void 0
                }).focusin(function () {
                    k.addClass("ui-chatbox-input-focus");
                    var b = a(this).parent().prev();
                    b.scrollTop(b.get(0).scrollHeight)
                }).focusout(function () {
                    k.removeClass("ui-chatbox-input-focus")
                });
            f.find("*").add(f).disableSelection(), i.children().click(function () {
                b.uiChatboxInputBox.focus()
            }), b._setWidth(b.options.width), b._position(b.options.offset), b.options.boxManager.init(b), b.options.hidden || e.show(), a(".ui-chatbox [rel=tooltip]").tooltip()
        },
        "_setOption": function (b, c) {
            if (null != c) switch (b) {
                case "hidden":
                    c ? this.uiChatbox.hide() : this.uiChatbox.show();
                    break;
                case "offset":
                    this._position(c);
                    break;
                case "width":
                    this._setWidth(c)
            }
            a.Widget.prototype._setOption.apply(this, arguments)
        },
        "_setWidth": function (a) {
            this.uiChatbox.width(a + 28 + "px"), this.uiChatboxInputBox.css("width", a + 18 + "px")
        },
        "_position": function (a) {
            this.uiChatbox.css("right", a)
        }
    })
}(jQuery),
function (a) {
    a.fn.emoticonize = function (b) {
        for (var c = a.extend({}, a.fn.emoticonize.defaults, b), d = [")", "(", "*", "[", "]", "{", "}", "|", "^", "<", ">", "\\", "?", "+", "=", "."], e = [":-)", ":o)", ":c)", ":^)", ":-D", ":-(", ":-9", ";-)", ":-P", ":-p", ":-\xde", ":-b", ":-O", ":-/", ":-X", ":-#", ":'(", "B-)", "8-)", ";*(", ":-*", ":-\\", "?-)", ": )", ": ]", "= ]", "= )", "8 )", ": }", ": D", "8 D", "X D", "x D", "= D", ": (", ": [", ": {", "= (", "; )", "; ]", "; D", ": P", ": p", "= P", "= p", ": b", ": \xde", ": O", "8 O", ": /", "= /", ": S", ": #", ": X", "B )", ": |", ": \\", "= \\", ": *", ": &gt;", ": &lt;"], f = [":)", ":]", "=]", "=)", "8)", ":}", ":D", ":(", ":[", ":{", "=(", ";)", ";]", ";D", ":P", ":p", "=P", "=p", ":b", ":\xde", ":O", ":/", "=/", ":S", ":#", ":X", "B)", ":|", ":\\", "=\\", ":*", ":&gt;", ":&lt;"], g = {
                "&gt;:)": {
                    "cssClass": "red-emoticon small-emoticon spaced-emoticon"
        },
                "&gt;;)": {
                    "cssClass": "red-emoticon small-emoticon spaced-emoticon"
        },
                "&gt;:(": {
                    "cssClass": "red-emoticon small-emoticon spaced-emoticon"
        },
                "&gt;: )": {
                    "cssClass": "red-emoticon small-emoticon"
        },
                "&gt;; )": {
                    "cssClass": "red-emoticon small-emoticon"
        },
                "&gt;: (": {
                    "cssClass": "red-emoticon small-emoticon"
        },
                ";(": {
                    "cssClass": "red-emoticon spaced-emoticon"
        },
                "&lt;3": {
                    "cssClass": "pink-emoticon counter-rotated"
        },
                "O_O": {
                    "cssClass": "no-rotate"
        },
                "o_o": {
                    "cssClass": "no-rotate"
        },
                "0_o": {
                    "cssClass": "no-rotate"
        },
                "O_o": {
                    "cssClass": "no-rotate"
        },
                "T_T": {
                    "cssClass": "no-rotate"
        },
                "^_^": {
                    "cssClass": "no-rotate"
        },
                "O:)": {
                    "cssClass": "small-emoticon spaced-emoticon"
        },
                "O: )": {
                    "cssClass": "small-emoticon"
        },
                "8D": {
                    "cssClass": "small-emoticon spaced-emoticon"
        },
                "XD": {
                    "cssClass": "small-emoticon spaced-emoticon"
        },
                "xD": {
                    "cssClass": "small-emoticon spaced-emoticon"
        },
                "=D": {
                    "cssClass": "small-emoticon spaced-emoticon"
        },
                "8O": {
                    "cssClass": "small-emoticon spaced-emoticon"
        },
                "[+=..]": {
                    "cssClass": "no-rotate nintendo-controller"
        }
        }, h = new RegExp("(\\" + d.join("|\\") + ")", "g"), i = "(^|[\\s\\0])", j = e.length - 1; j >= 0; --j) e[j] = e[j].replace(h, "\\$1"), e[j] = new RegExp(i + "(" + e[j] + ")", "g");
        for (var j = f.length - 1; j >= 0; --j) f[j] = f[j].replace(h, "\\$1"), f[j] = new RegExp(i + "(" + f[j] + ")", "g");
        for (var k in g) g[k].regexp = k.replace(h, "\\$1"), g[k].regexp = new RegExp(i + "(" + g[k].regexp + ")", "g");
        var l = "span.css-emoticon";
        c.exclude && (l += "," + c.exclude);
        var m = l.split(",");
        return this.not(l).each(function () {
            var b = a(this),
                d = "css-emoticon";
            c.animate && (d += " un-transformed-emoticon animated-emoticon");
            for (var h in g) specialCssClass = d + " " + g[h].cssClass, b.html(b.html().replace(g[h].regexp, "$1<span class='" + specialCssClass + "'>$2</span>"));
            a(e).each(function () {
                b.html(b.html().replace(this, "$1<span class='" + d + "'>$2</span>"))
            }), a(f).each(function () {
                b.html(b.html().replace(this, "$1<span class='" + d + " spaced-emoticon'>$2</span>"))
            }), a.each(m, function (c, d) {
                b.find(a.trim(d) + " span.css-emoticon").each(function () {
                    a(this).replaceWith(a(this).text())
                })
            }), c.animate && setTimeout(function () {
                a(".un-transformed-emoticon").removeClass("un-transformed-emoticon")
            }, c.delay)
        })
    }, a.fn.unemoticonize = function (b) {
        var c = a.extend({}, a.fn.emoticonize.defaults, b);
        return this.each(function () {
            var b = a(this);
            b.find("span.css-emoticon").each(function () {
                var b = a(this);
                c.animate ? (b.addClass("un-transformed-emoticon"), setTimeout(function () {
                    b.replaceWith(b.text())
                }, c.delay)) : b.replaceWith(b.text())
            })
        })
    }, a.fn.emoticonize.defaults = {
        "animate": !0,
        "delay": 500,
        "exclude": "pre,code,.no-emoticons"
    }
}(jQuery);