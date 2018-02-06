Array.prototype.filter = function(g) {
    try {
        var f = this.length;
        var e = new Array();
        for (var b = 0; b < f; b++) {
            var d = this[b];
            if (g(d, b, this)) {
                e.push(this[b])
            }
        }
        return e
    } catch(c) {
        var a = "Array.filter存在一个错误。\n\n";
        a += "错误描述:" + c.description + "\n\n";
        a += "点击确定继续。\n\n";
        alert(a)
    }
};
Array.prototype.removeAt = function(b) {
    if (isNaN(b) || b > this.length) {
        return false
    }
    for (var a = 0,
         c = 0; a < this.length; a++) {
        if (this[a] != this[b]) {
            this[c++] = this[a]
        }
    }
    this.length -= 1
};
Array.prototype.remove = function(b) {
    if (null == b) {
        return
    }
    for (var a = 0,
         c = 0; a < this.length; a++) {
        if (this[a] != b) {
            this[c++] = this[a]
        }
    }
    this.length -= 1
};
Array.prototype.Contains = function(b) {
    if (null == b) {
        return
    }
    for (var a = 0,
         c = 0; a < this.length; a++) {
        if (this[a] == b) {
            return true
        }
    }
    return false
};
Array.prototype.indexOf = function(b) {
    if (null == b) {
        return
    }
    for (var a = 0,
         c = 0; a < this.length; a++) {
        if (this[a] == b) {
            return a
        }
    }
    return - 1
};
Array.prototype.Clear = function() {
    this.length = 0
};
Array.prototype.removeVoidElement = function() {
    for (var a = 0; a < this.length; a++) {
        if ("" == this[a] || null == this[a] || "null" == this[a]) {
            this.remove(this[a])
        }
    }
};
$(document).ready(function() {
                  var a = "";
                  a += '<div class="mdui-list" mdui-collapse="{accordion: true}" style="margin-bottom:76px"><ul class="mdui-list"><a href="./script_choose.html" class="mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-blue">&#xe873;</i><div class="mdui-list-item-content">脚本选择</div></a> <a href="./xxtouch_auth.html" class="mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-deep-orange">&#xe0da;</i><div class="mdui-list-item-content">授权</div></a> <a href="./xxtouch_service.html" class="mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-indigo">&#xe0de;</i><div class="mdui-list-item-content">设备与服务</div></a> <a href="./log.html" class="mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-brown">&#xe85d;</i><div class="mdui-list-item-content">设备日志</div></a></ul><div class="mdui-collapse-item"><div class="mdui-collapse-item-header mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-green">&#xe8b8;</i><div class="mdui-list-item-content">设置</div><i class="mdui-collapse-item-arrow mdui-icon material-icons">&#xe313;</i></div><div class="mdui-collapse-item-body mdui-list"><a href="./action_conf.html" class="mdui-list-item mdui-ripple">按键设置</a> <a href="./startup_conf.html" class="mdui-list-item mdui-ripple">开机启动设置</a> <a href="./user_conf.html" class="mdui-list-item mdui-ripple">用户偏好设置</a></div></div><ul class="mdui-list"><a href="./applist.html" class="mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-red">&#xe5c3;</i><div class="mdui-list-item-content">应用列表</div></a> <a href="./picker.html" class="mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-cyan">&#xe410;</i><div class="mdui-list-item-content">抓色器</div></a> <a href="./cc.html" class="mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-cyan">&#xe1b1;</i><div class="mdui-list-item-content">局域网集中控制</div></a> <a href="./screen.html" class="mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-brown">&#xe1bc;</i><div class="mdui-list-item-content">实时桌面</div></a> <a href="./upgrade.html" class="mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-purple">&#xe62a;</i><div class="mdui-list-item-content">软件升级</div></a> <a href="./encript.html" class="mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-teal">&#xe63f;</i><div class="mdui-list-item-content">脚本加密</div></a></ul><div class="mdui-collapse-item"><div class="mdui-collapse-item-header mdui-list-item mdui-ripple"><i class="mdui-list-item-icon mdui-icon material-icons mdui-text-color-deep-purple">&#xe06f;</i><div class="mdui-list-item-content">文档</div><i class="mdui-collapse-item-arrow mdui-icon material-icons">&#xe313;</i></div><div class="mdui-collapse-item-body mdui-list"><a href="https://www.zybuluo.com/xxtouch/note/370734" target="_blank" class="mdui-list-item mdui-ripple">开发文档</a> <a href="https://www.zybuluo.com/xxtouch/note/386268" target="_blank" class="mdui-list-item mdui-ripple">OpenAPI文档</a> <a href="https://www.zybuluo.com/xxtouch/note/714654" target="_blank" class="mdui-list-item mdui-ripple">使用手册</a> <a href="https://www.zybuluo.com/xxtouch/note/386289" target="_blank" class="mdui-list-item mdui-ripple">更新日志</a> <a href="./about.html" class="mdui-list-item mdui-ripple">关于</a></div></div></div>\n';
                  $("#main-drawer").append(a);
                  if ( !! window.ActiveXObject || "ActiveXObject" in window) {
                  mdui.snackbar({
                                message: "为了确保浏览的完整性和体验性，请使用IE浏览器以外的任何浏览器进行访问。<br >如果是国内浏览器请选择使用<b>极速模式</b>浏览",
                                position: "top",
                                timeout: 30000,
                                buttonText: "获取Chrome",
                                closeOnOutsideClick: true,
                                onButtonClick: function() {
                                location.href = "http://www.google.cn/chrome/browser/desktop/index.html"
                                }
                                })
                  }
                  });
