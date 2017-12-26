/*----------------------------------------------------------------------------
markItUp!
----------------------------------------------------------------------------
Copyright (C) 2011 Jay Salvat
http://markitup.jaysalvat.com/
----------------------------------------------------------------------------
Html tags
http://en.wikipedia.org/wiki/html
----------------------------------------------------------------------------
Basic set. Feel free to add more tags
----------------------------------------------------------------------------
*/
var mySettings = {
    previewParserPath:  '/admin/markdown/preview',
	onShiftEnter:  	{keepDefault:false, replaceWith:'<br />\n'},
	onCtrlEnter:  	{keepDefault:false, openWith:'\n<p>', closeWith:'</p>'},
	onTab:    		{keepDefault:false, replaceWith:'    '},
	markupSet:  [
        {name:'Заголовок першого рівня', key:"1", openWith:'# '},
        {name:'Заголовок другого рівня', key:"2", openWith:'## '},
        {name:'Заголовок третього рівня', key:"3", openWith:'### '},
        {name:'Заголовок четвертого рівня', key:"4", openWith:'#### '},
        {name:'Заголовок п\'ятого рівня', key:"5", openWith:'##### '},
        {name:'Заголовок шостого рівня', key:"6", openWith:'###### '},
        {separator:'---------------' },
        {name:'Жирний', key:'B', openWith: '**', closeWith: '**' },
        {name:'Курсив', key:'I', openWith:'_', closeWith:'_' },
        {name:'Закреслений', key:'S', openWith:'~~', closeWith:'~~' },
        {separator:'---------------' },
        {name:'Ненумерований список', openWith:'- ', multiline:true, openBlockWith:'<ul>\n', closeBlockWith:'\n</ul>'},
        {name:'Нумерований список', openWith:function(markItUp) { return markItUp.line+'. ' }},
        {separator:'---------------' },
        {name:'Зображення', key:'P', replaceWith:'![[![Alternative text]!]]([![Url:!:http://]!] "[![Title]!]")' },
        {name:'Посилання', key:'L', openWith:'[', closeWith:']([![Url:!:http://]!] "[![Title]!]")', placeHolder:'Your text to link here...' },
        {separator:'---------------' },
        {name:'Почистити', className:'clean', replaceWith:function(markitup) { return markitup.selection.replace(/<(.*?)>/g, "") } },
		{name:'Переглянути', className:'preview',  call:'preview'}
	]
};

$(window).bind("turbolinks:load",function(e){
    $('#post_body').markItUp(mySettings);
});
