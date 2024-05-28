package production

import input.plan as tfplan

deny[msg] {
    resources := tfplan.resource_changes[_]
    resources.type == "google_compute_firewall"
    resources.change.after.source_ranges[_] == "0.0.0.0/0"
    msg := sprintf("%v has 0.0.0.0/0 as allowed ingress", [resources[_].address])
}