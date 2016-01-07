window.addEventListener("DOMContentLoaded", function(){
	btn = document.getElementById("plug-btn");
	btn.onclick = function(){
		var divs = document.getElementById("plug-phone").querySelectorAll("div");
		var className = className=this.checked?"on":"";
		for(i = 0;i<divs.length; i++){
			divs[i].className = className;
		}
	}
}, false);
$(function(){
    $("a,.box-nav a").on({
        touchstart:function(){
            $(this).addClass("active");
        },
        touchend:function(){
             $(this).removeClass("active");
        }
    });
    //欢迎页面
    setTimeout(function(){
        $("#pageShow").animate({
            "left": "-=50px",
            opacity:0.9
        }, "slow").animate({
                "left": "+=50px",
                opacity:0.9
            }, "slow").animate({
                "left": "-=30px",
                opacity:0.8
            }, "slow").animate({
                "left": "+=30px",
                opacity:0.8
            }, "slow").animate({
                "left": "-=100%",
                opacity:0
            }, "slow");
    },2000);
    $(".box-page a").click(function(){
        var pages=$(".box-page"),
            self=$(this);
        pages.find("a").removeClass("active");
        self.addClass("active");
    });
    //分类
	$(".ico-list").on("click",function(){
        var h=$(document).height();
        $(".pop-nav").height(h);
        $(".pop-bg").height(h);
		$(".pop-nav").show();
		$(".pop-nav .pop-bd").addClass("on");
	});
	$(".pop-nav .hd, .pop-nav .pop-bg").on("click",function(){
		$(".pop-nav").fadeOut();
	});
	$(".pop-nav .pop-bd dt").on("click",function(){
		var self=$(this),
				parent=self.parents(".bd"),
				dt=parent.find("dt");
		if(self.hasClass("active")){
			dt.removeClass("active");
			parent.find("dl").removeClass("active");
			dt.find(".ico").removeClass("ico-angle-down").addClass("ico-angle-right");
		}else{
			parent.find("dl").removeClass("active");
			dt.removeClass("active");
			dt.find(".ico").removeClass("ico-angle-down").addClass("ico-angle-right");
			self.find(".ico").removeClass("ico-angle-right").addClass("ico-angle-down");
			self.parent("dl").andSelf().addClass("active");
		}	
	});
	$(".pop-nav dd a").on("click",function(){
		var self=$(this),
			dd=self.parent("dd");
		dd.find("a").removeClass("active");
		self.addClass("active");
		$(".pop-nav").hide();
	});
	//btn-music
    $(".btn-music").click(function(){
        $(this).toggleClass("active");
    });
    //发送给朋友 & 分享到朋友圈
	$(".btn-share").on("click",function(){
        var h=$(document).height();
        $(".pop-share").height(h);
        $(".pop-bg").height(h);
		$(".pop-share").show();
	});
	$(".pop-share").on("click",function(){
		$(".pop-share").fadeOut();
	});
    //底部导航栏
    $(".box-nav-ft p").click(function(){
        $(".box-nav-ft p").children().fadeOut();
        $(this).children().toggle();
    });
    $(".box-nav-ft a").click(function(){
        $(".box-nav-ft p").children().fadeOut();
    });
    $(".box-ft a, .box-nav-ft p").on({
        touchstart:function(){
            $(this).addClass("active");
        },
        touchend:function(){
             $(this).removeClass("active");
        }
    });
    $(".box-ft p").click(function(){
        var self=$(this);
        if(self.hasClass("open")){
            self.removeClass("open");
        }else{
            $(".box-ft p").removeClass("open");
            self.addClass("open");
        }
    });
});
