'use strict';
var $image = $('.avatar-wrapper > img'),
$dataX = $('#dataX'),
$dataY = $('#dataY'),
$dataHeight = $('#dataHeight'),
$dataWidth = $('#dataWidth'),
$dataRotate = $('#dataRotate'),
options = {
  aspectRatio: 1/1,
  preview: '.img-preview',
  crop: function (data) {
    $dataX.val(Math.round(data.x));
    $dataY.val(Math.round(data.y));
    $dataHeight.val(Math.round(data.height));
    $dataWidth.val(Math.round(data.width));
    $dataRotate.val(Math.round(data.rotate));
  }
};
$image.on({
		'build.cropper': function (e) {},
        'built.cropper': function (e) {},
        'dragstart.cropper': function (e) {},
        'dragmove.cropper': function (e) {},
        'dragend.cropper': function (e) {},
        'zoomin.cropper': function (e) {},
        'zoomout.cropper': function (e) {}
    }).cropper(options);
$('[data-toggle="tooltip"]').tooltip();