/**
 * js工具包
 * @Author: yjmyzz@126.com
 * @Version: 0.1 beta
 * @Since: 2015-03-01
 * @LastUpdate: 2015-06-11
 */

var ylib = {version: "0.1 beta"};

/**
 * 去掉二边多余空格
 * @param str
 * @returns {string}
 */
ylib.trim = function (str) {
    return str.replace(/(^[\s]*)|([\s]*$)/g, "");
};

/**
 * 去掉左边多余空格
 * @param str
 * @returns {string}
 */
ylib.leftTrim = function (str) {
    return str.replace(/(^[\s]*)/g, "");
};

/**
 * 去掉右侧多余空格
 * @param str
 */
ylib.rightTrim = function (str) {
    return str.replace(/([\s]*$)/g, "");
};

/**
 * 字符串去二边空格并转大写
 */
ylib.trimAndUpper = function (str) {
    return ylib.trim(str).toUpperCase();
};

/**
 * 判断字符串是否为空
 * @param str
 * @returns {boolean}
 */
ylib.isEmpty = function (str, isTrim) {
    if (isTrim != undefined && isTrim) {
        str = ylib.trim(str);
    }
    return str == null || !str || typeof str == undefined || str == '';
};

/**
 * 检测字符串是否电子邮件格式
 */
ylib.isEmail = function (str) {
    return (/^[\w-]+@[\w-]+(\.[\w-]+)+$/).test(str);
};

/**
 * 字符串转整形
 * @param str
 * @returns {*}
 */
ylib.parseInt = function (str) {
    if (typeof str == 'number') {
        return str;
    } else if (typeof str == 'string') {
        var ret = parseInt(str);

        if (isNaN(ret) || !isFinite(ret)) {
            return 0;
        }

        return ret;
    } else {
        return 0;
    }
};

/**
 * 字符串转浮点数
 * @param str
 * @returns {*}
 */
ylib.parseFloat = function (str) {
    if (typeof str == 'number') {
        return str;
    } else if (typeof str == 'string') {
        var ret = parseFloat(str);
        if (isNaN(ret) || !isFinite(ret)) {
            return 0;
        }

        return ret;
    } else {
        return 0;
    }
};

/**
 * 字符串转浮点数(字符串接受","字符串，此方法将过滤掉",")
 * @param str
 * @returns {*}
 */
ylib.parseDotFloat = function (str) {
    if (typeof str == 'number') {
        return str;
    } else if (typeof str == 'string') {
        str = str.replace(/[^\d|.]/g, '');
        str = parseFloat(str);

        if (isNan(str) || !isFinite(str)) {
            return 0
        }
        return ret;
    } else {
        return 0;
    }
};

/**
 * 为element元素添加事件处理函数
 * @param element 元素
 * @param event 事件名称
 * @param handler 事件处理函数
 * @param param 事件处理函数的参数
 */
ylib.addEventListener = function (element, event, handler, param) {
    param.scope = param.scope || element;

    if (typeof element == 'string') {
        element = $(element);
    }

    var h = function () {
        handler.call(param.scope, param);
    }

    if (element.attachEvent) {
        element.attachEvent('on' + event, h);

    } else if (element.addEventListener) {
        element.addEventListener(event, h, false);

    } else {
        element['on' + event] = h;
    }
};

//判断是否为yyyy-MM-dd HH:mm:ss格式
ylib.isDateTime = function (str) {
    var reg = /^((\d{2}(([02468][048])|([13579][26]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|([1-2][0-9])))))|(\d{2}(([02468][1235679])|([13579][01345789]))[\-\/\s]?((((0?[13578])|(1[02]))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\-\/\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\-\/\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))(\s(((0?[0-9])|([1][0-9])|([2][0-4]))\:([0-5]?[0-9])((\s)|(\:([0-5]?[0-9])))))?$/
    if (reg.test(str)) return true;
    return false;
};

/**
 * 字符串左填充
 * @param str
 * @param len
 * @param padChar
 * @returns {*}
 */
ylib.padLeft = function (str, len, padChar) {
    len = len - (str + '').length;
    if (padChar == undefined || padChar == "") {
        padChar = "0";
    }
    for (var i = 0; i < len; i++) {
        str = padChar + str;
    }
    return str;
};

/**
 * 给date1增加指定天数
 * @param date1
 * @param day
 * @returns {*}
 */
ylib.addDay = function (date1, day) {
    date1.setTime(date1.getTime() + (day * 24 * 60 * 60 * 1000));
    return date1;
};

/**
 * 给日期增加指定月份
 * @param date
 * @param month
 * @returns {Date}
 */
ylib.addMonth = function (date, month) {
    var year = date.getFullYear();
    var month = date.getMonth() + month;
    date = new Date(year, month, date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds(), date.getMilliseconds());
    return date;
};

/**
 * 给日期增加指定年份
 * @param date
 * @param year
 * @returns {Date}
 */
ylib.addYear = function (date, year) {
    date = new Date(date.getFullYear() + year, date.getMonth(), date.getDate(), date.getHours(), date.getMinutes(), date.getSeconds(), date.getMilliseconds());
    return date;
};

/**
 * 给指定日期增加小时数
 * @param date
 * @param hour
 * @returns {*}
 */
ylib.addHour = function (date, hour) {
    date.setTime(date.getTime() + (hour * 60 * 60 * 1000));
    return date;
};

/**
 * 给指定日期增加分钟数
 * @param date
 * @param minute
 * @returns {*}
 */
ylib.addMinute = function (date, minute) {
    date.setTime(date.getTime() + (minute * 60 * 1000));
    return date;
};

/**
 * 给指定日期增加秒数
 * @param date
 * @param second
 * @returns {*}
 */
ylib.addSecond = function (date, second) {
    date.setTime(date.getTime() + (second * 1000));
    return date;
};

/**
 * 将日期或日期字符串格式化
 * @param params：date类型的值 或 yyyy-MM-dd HH:mm:dd格式的字符串
 * @param format： yyyy-MM-dd 或 yyyyMMdd 等
 * @returns {*}
 */
ylib.dateFormat = function (params, format) {
    if (params == null || params == undefined || params.length <= 0) {
        return new Date();
    }

    var isUTCFormat = true; //是否标准UTC格式
    if (ylib.isDateTime(params)) {
        isUTCFormat = false;
    }

    var pattern = /\d+/g;
    var r = pattern.exec(params);

    var date = null;

    if (typeof(params) == "string") {
        date = new Date(parseInt(r[0]));
    }
    else {
        date = params;
    }

    if (format == undefined || format == "") {
        format = "yyyy-MM-dd HH:mm:ss";
    }
    var year = date.getFullYear();
    var month = ylib.padLeft((date.getMonth() + 1), 2, '0');
    var day = ylib.padLeft((date.getDate()), 2, '0');
    var hour = ylib.padLeft(date.getHours(), 2, '0');
    var minute = ylib.padLeft(date.getMinutes(), 2, '0');
    var second = ylib.padLeft(date.getSeconds(), 2, '0');

    if (!isUTCFormat) {
        var arr = params.split(' ');
        var year_month_day = arr[0].split('-');
        var hour_minute_second = arr[1].split(':');

        year = year_month_day[0];
        month = year_month_day[1];
        day = year_month_day[2];

        hour = hour_minute_second[0];
        minute = hour_minute_second[1];
        second = hour_minute_second[2];
    }

    if (year + "-" + month + "-" + day == "0001-01-01")
        return "";

    switch (format) {
        case "yyyyMM":
            return year + "" + month;
        case "yyyyMMdd":
            return year + "" + month + "" + day;
        case "yyyy-MM-dd":
            return year + "-" + month + "-" + day;
        case "yyyy-MM-dd HH:mm":
            return year + "-" + month + "-" + day + " " + hour + ":" + minute;
        case "HH:mm":
            return hour + ":" + minute;
        default:
            return year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second;
    }
};

/**
 * 检查element元素内容是否为空，则空则提示msg
 * @param element
 * @param emptyMessage
 * @returns {boolean}
 */
ylib.checkIsNotEmpty = function (element, emptyMessage) {
    if (typeof element == 'string') {
        element = $(element);
    }

    if (Util.strIsEmpty(element.value)) {
        alert(emptyMessage);
        if (!element.disabled) {
            element.focus();
            element.select();
        }
        return false;
    }
    return true;
};

/**
 * 字符串转日期
 * @param str 格式：yyyy-mm-dd
 * @returns {*}
 */
ylib.str2date = function (str) {
    var re = /^(\d{4})\S(\d{1,2})\S(\d{1,2})$/;
    var dt;
    if (re.test(str)) {
        dt = new Date(RegExp.$1, RegExp.$2 - 1, RegExp.$3);
    }
    return dt;
};

/**
 * 计算2个日期之间的天数
 * @param day1
 * @param day2
 * @returns {day2 - day1的天数差}
 */
ylib.dayMinus = function (day1, day2) {
    var days = Math.floor((day2 - day1) / (1000 * 60 * 60 * 24));
    return days;
};

/**
 * 设置组合列表框选择项
 * @param combo 组合列表框
 * @param value 选择值
 * @param defaultIdx 默认选中项的序号
 */
ylib.setComboSelected = function (combo, value, defaultIdx) {
    if (typeof combo == 'string') {
        combo = $(combo);
    }

    var idx = defaultIdx;
    if (typeof defaultIdx == 'undefined') {
        idx = -1;
    }

    for (var i = 0, len = combo.options.length; i < len; ++i) {
        var v = combo.options[i].value;
        if (v == value) {
            idx = i;
            break;
        }
    }
    combo.selectedIndex = idx;
};

/**
 * 设置input框的值
 * @param element
 * @param value
 */
ylib.setInputValue = function (element, value) {
    $(element).value = value;
};


/**
 * 表单必填项验证
 * 约定：必须项input，必须添加 require="true"属性，验证失败提示信息，添加 require-msg="XXX"属性
 * @param formId 表单id，比如: #frmQuery
 * @returns {boolean}
 */
ylib.checkInput = function (formId) {
    //文本输入框
    var requireInputs = $(formId + " input[require='true']");
    for (var i = 0; i < requireInputs.length; i++) {
        var el = requireInputs[i];
        if (ylib.isEmpty($(el).val(), true)) {
            alert("[" + $(el).attr("require-msg") + "]必须输入！");
            if (!el.disabled) {
                el.focus();
                el.select();
            }
            return false;
        }
    }

    //下拉框
    var requireInputs = $(formId + " select[require='true']");
    for (var i = 0; i < requireInputs.length; i++) {
        var el = requireInputs[i];
        if (ylib.isEmpty($(el).val(), true)) {
            alert("[" + $(el).attr("require-msg") + "]必须输入！");
            if (!el.disabled) {
                el.focus();
            }
            return false;
        }
    }

    return true;
}

ylib.parseURL = function (url) {
    var a = document.createElement('a');
    a.href = url;
    return {
        source: url,
        protocol: a.protocol.replace(':', ''),
        host: a.hostname,
        port: a.port,
        query: a.search,
        params: (function () {
            var ret = {},
                seg = a.search.replace(/^\?/, '').split('&'),
                len = seg.length, i = 0, s;
            for (; i < len; i++) {
                if (!seg[i]) {
                    continue;
                }
                s = seg[i].split('=');
                ret[s[0]] = s[1];
            }
            return ret;

        })(),
        file: (a.pathname.match(/\/([^\/?#]+)$/i) || [, ''])[1],
        hash: a.hash.replace('#', ''),
        path: a.pathname.replace(/^([^\/])/, '/$1'),
        relative: (a.href.match(/tps?:\/\/[^\/]+(.+)/) || [, ''])[1],
        segments: a.pathname.replace(/^\//, '').split('/')
    };
}