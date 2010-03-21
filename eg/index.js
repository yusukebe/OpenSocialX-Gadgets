function init() {
  var req = opensocial.newDataRequest();
  req.add(req.newFetchPersonRequest(opensocial.IdSpec.PersonId.VIEWER), "viewer");
  req.send(function(data) {
    var viewer = data.get("viewer").getData();
    var name = viewer.getDisplayName();
    document.getElementById("target").innerHTML = name;
    });
}
gadgets.util.registerOnLoadHandler(init);
