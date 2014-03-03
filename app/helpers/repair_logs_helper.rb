module RepairLogsHelper
  def op_link(repair_log) 
    links = []
    repair_log.op_links.map do |link| 
      links <<  eval("link_to_l link.to_s, #{link}_repair_log_path(repair_log)")
    end

    links
  end
end
