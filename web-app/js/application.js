if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}


var table;

$(document).ready(function () {


	var config = {
	'.chosen-select'           : {},
	'.chosen-select-deselect'  : {allow_single_deselect:true},
	'.chosen-select-no-single' : {disable_search_threshold:10},
	'.chosen-select-no-results': {no_results_text:'Oops, nothing found!'},
	'.chosen-select-width'     : {width:"95%"}
	}
	for (var selector in config) {
		$(selector).chosen(config[selector]);
	}


	/* dataTablesList */
	$('.dataTablesList tfoot th').each( function () {
        var title = $('.dataTablesList thead th').eq( $(this).index() ).text();
        console.log($(this).index())
        if($(this).index() !=0 ){
        	$(this).html( '<input type="text" placeholder="Search '+title+'" />' );	
        }
        
    });
 
    // DataTable
    table = $('.dataTablesList').DataTable({
    	"paging": true,
	     "lengthChange": false,
	     "searching": true,
	     "ordering": true,
	     "info": true,
	     "autoWidth": true,
	     "scrollX": true
    });
 
    // Apply the search
    table = table.columns().eq( 0 );
    if(table){
    table.columns().eq( 0 ).each( function ( colIdx ) {
    	
    	
    		$( 'input', table.column( colIdx ).footer() ).on( 'keyup change', function () {
            table
                .column( colIdx )
                .search( this.value )
                .draw();
        	} );
    	
    });
    }

/*    $('#chat-box').slimScroll({
        height: '150px'
    });*/

});

function formatNumber(val,row){
	if (val==null){val=0.0}
    if (val < 0){
        return '<span style="color:red;">('+numeral(val).format('0,0.00')+')</span>';
    } else {
        return numeral(val).format('0,0.00');
    }
}

if ($('#back-to-top').length) {
    var scrollTrigger = 100, // px
        backToTop = function () {
            var scrollTop = $(window).scrollTop();
            if (scrollTop > scrollTrigger) {
                $('#back-to-top').addClass('show');
            } else {
                $('#back-to-top').removeClass('show');
            }
        };
    backToTop();
    $(window).on('scroll', function () {
        backToTop();
    });
    $('#back-to-top').on('click', function (e) {
        e.preventDefault();
        $('html,body').animate({
            scrollTop: 0
        }, 700);
    });
}



