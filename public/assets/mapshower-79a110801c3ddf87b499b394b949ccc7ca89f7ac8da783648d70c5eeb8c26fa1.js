$('#img-modified').mapster({
    fillColor: '2252a9', // добавляем цвет при наведении
    fillOpacity: 0.7, // добавляем прозрачность цвета при наведении
    staticState: true, // подсвечиваем выделенные области
    showToolTip: true, // указываем, что нужно показывать toolTip
    mapKey: 'id', // добавляем тот идентификатор,
    // по которому мы будем обращаться
    // к конкретной области area
    areas: [ // подсказка для каждой отдельной области area
        { key: "place_1", toolTip: $("#place_1").attr('title') },
        { key: "place_2", toolTip: $("#place_2").attr('title') },
        { key: "place_3", toolTip: $("#place_3").attr('title') },
        { key: "place_4", toolTip: $("#place_4").attr('title') },
        { key: "place_5", toolTip: $("#place_5").attr('title') },
        { key: "place_6", toolTip: $("#place_6").attr('title') },
        { key: "place_7", toolTip: $("#place_7").attr('title') },
        { key: "place_8", toolTip: $("#place_8").attr('title') },
        { key: "place_9", toolTip: $("#place_9").attr('title') },
        { key: "place_10", toolTip: $("#place_10").attr('title') },
        { key: "place_11", toolTip: $("#place_11").attr('title') },
        { key: "place_12", toolTip: $("#place_12").attr('title') },
        { key: "place_13", toolTip: $("#place_13").attr('title') },
        { key: "place_14", toolTip: $("#place_14").attr('title') },
        { key: "place_15", toolTip: $("#place_15").attr('title') },
        { key: "place_16", toolTip: $("#place_16").attr('title') },
        { key: "place_17", toolTip: $("#place_17").attr('title') },
        { key: "place_18", toolTip: $("#place_18").attr('title') },
        { key: "place_19", toolTip: $("#place_19").attr('title') },
        { key: "place_20", toolTip: $("#place_20").attr('title') },
        { key: "place_21", toolTip: $("#place_21").attr('title') },
        { key: "place_22", toolTip: $("#place_22").attr('title') },
        { key: "place_23", toolTip: $("#place_23").attr('title') },
        { key: "place_24", toolTip: $("#place_24").attr('title') },
        { key: "place_25", toolTip: $("#place_25").attr('title') }
    ]
});
