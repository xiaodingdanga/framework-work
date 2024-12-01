<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>jQuery-webcam-master</title>
    <link href="cs.css" rel="stylesheet" type="text/css">
    <script src="jquery-1.7.2.min.js"></script>
    <script src="jquery.webcam.min.js"></script>
    <script type="text/javascript">
        $(function() {

            var pos = 0, ctx = null, saveCB, image = [];
//创建画布指定宽度和高度
            var canvas = document.createElement("canvas");
            canvas.setAttribute('width', 320);
            canvas.setAttribute('height', 240);
//如果画布成功创建
            if (canvas.toDataURL) {
//设置画布为2d，未来可能支持3d
                ctx = canvas.getContext("2d");
//截图320*240，即整个画布作为有效区(cutx?)
                image = ctx.getImageData(0, 0, 320, 240);

                saveCB = function(data) {
//把data切割为数组
                    var col = data.split(";");
                    var img = image;
//绘制图像(这里不是很理解算法)
//参数data  只是每行的数据  ，例如320*240 大小的照片，一张完整的照片下来需要240个data，每个data有320个rgb
                    for(var i = 0; i < 320; i++) {
                        //转换为十进制
                        var tmp = parseInt(col[i]);
                        img.data[pos + 0] = (tmp >> 16) & 0xff;
                        img.data[pos + 1] = (tmp >> 8) & 0xff;
                        img.data[pos + 2] = tmp & 0xff;
                        img.data[pos + 3] = 0xff;
                        pos+= 4;
                    }
//当绘制320*240像素的图片时发给后端php
                    if (pos >= 4 * 320 * 240) {
//把图像放到画布上,输出为png格式
                        ctx.putImageData(img, 0, 0);
                        $.post("upload.php", {type: "data", image: canvas.toDataURL("image/png")});
                        pos = 0;
                    }
                };

            } else {
                saveCB = function(data) {
//把数据一点点的放入image[]
                    image.push(data);
                    pos+= 4 * 320;
                    if (pos >= 4 * 320 * 240) {
                        $.post("upload.php", {type: "pixel", image: image.join('|')});
                        pos = 0;
                    }
                };
            }
            $("#webcam").webcam({
                width: 320,
                height: 240,
                mode: "callback",
                swffile: "jscam_canvas_only.swf",

                onSave: saveCB,

                onCapture: function () {
                    webcam.save();
                },

                debug: function (type, string) {
                    console.log(type + ": " + string);
                }
            });
//            /**
//             * 获取canvas画布的内容 getImageData
//             * 内容放回到canvas画布 putImageData
//             * 获取ImgData的每一个像素 ImgData.data
//             * getImageData(起始点的横坐标, 起始点的纵坐标, 获取的宽度, 获取的高度)
//             * putImageData(绘制点的横坐标, 绘制点点纵坐标, imgData的起始点横坐标, imgData的起始点纵坐标, 宽度, 高度)
//             */
        });
    </script>
</head>
<body>
<div id="webcam"></div>
<input type="button" onclick="webcam.capture();" value="点击触发" >
</body>

</html>

