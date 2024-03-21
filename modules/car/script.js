function initCarCalendar(min, max) {
  var y = new Date().getFullYear();
  new Calendar("car-calendar", {
    minYear: Math.min(min, y),
    maxYear: Math.max(max, y),
    url: WEB_URL + "index.php/car/model/calendar/toJSON",
    onclick: function() {
      send(
        WEB_URL + "index.php/car/model/index/action",
        "action=detail&id=" + this.id,
        doFormSubmit
      );
    }
  });
  forEach($E('car_links').getElementsByTagName('a'), function() {
    callClick(this, function() {
      send(
        WEB_URL + "index.php/car/model/vehicles/action",
        'action=detail&id=' + this.id.replace('car_', ''),
        doFormSubmit,
        this
      );
    });
  });
}

function initCarApprove() {
  $G('begin_date').addEvent("change", function() {
    if (this.value) {
      $G('end_date').min = this.value;
    }
  });
  var doApprove = function() {
    var id = floatval($E('id').value),
      value = this.id.replace('change_status', '');
    if (confirm(trans("YOU_WANT_TO_XXX").replace("XXX", this.innerHTML))) {
      if (id > 0) {
        let q = 'action=approve&id=' + id + '&status=' + value;
        send(WEB_URL + 'index.php/car/model/report/action', q, doFormSubmit, this)
      }
    }
  };
  callClick('change_status1', doApprove);
  callClick('change_status2', doApprove);
}

function initCarApproved() {
  var doChanged = function() {
    let status = $E('approved_status').value;
    $E('approved_reason').parentNode.parentNode.style.display = status == 2 ? null : 'none';
    $E('approved_chauffeur').parentNode.parentNode.style.display = status == 1 ? null : 'none';
  };
  $G('approved_status').addEvent('change', doChanged);
  doChanged.call(this);
}

function initCarSettings() {
  let doChanged = function() {
    let level = $E('car_approve_level').value.toInt();
    forEach($E('verfied').getElementsByTagName('select'), function() {
      let ds = /car_approve_status([0-9]+)/.exec(this.id);
      if (ds) {
        $E('car_approve_department' + ds[1]).parentNode.parentNode.parentNode.parentNode.style.display = level > 0 && level >= ds[1].toInt() ? null : 'none';
      }
    });
  };
  $G('car_approve_level').addEvent('change', doChanged);
  doChanged.call(this);
}
