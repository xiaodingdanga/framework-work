<?php
//$str = file_get_contents("php://input");
//file_put_contents("upload.jpg",  pack("H*", $str));
//var_dump($_POST['image']);

if ($_POST['type'] == "pixel") {
    // input is in format 1,2,3...|1,2,3...|...
    $im = imagecreatetruecolor(320, 240);

    foreach (explode("|", $_POST['image']) as $y => $csv) {
        foreach (explode(";", $csv) as $x => $color) {
            imagesetpixel($im, $x, $y, $color);
        }
    }
} else {
    // input is in format: data:image/png;base64,...
    $im = imagecreatefrompng($_POST['image']);
}
imagepng($im,"circle".time().".png");//保存
imagedestroy($im);
// do something with $im