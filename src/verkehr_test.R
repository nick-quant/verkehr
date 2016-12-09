setwd('C:\\home\\private\\verkehr')

our_columns = c(1, 2, 6, 12)
column_classes = rep('NULL', 18)
column_classes[our_columns] = NA

ngsim_file = 'data\\vdata_list.rds'
if (!file.exists(ngsim_file)) {
    vtbl_1 = read.table('data/vehicle-trajectory-data/0750am-0805am/trajectories-0750am-0805am.data', header = FALSE,
                        sep = '', colClasses = column_classes)
    vtbl_2 = read.table('data/vehicle-trajectory-data/0805am-0820am/trajectories-0805am-0820am.data', header = FALSE,
                        sep = '', colClasses = column_classes)
    vtbl_3 = read.table('data/vehicle-trajectory-data/0820am-0835am/trajectories-0820am-0835am.data', header = FALSE,
                        sep = '', colClasses = column_classes)
    vdata_list = list(vtbl_1, vtbl_2, vtbl_3)
    vdata_list = lapply(X = vdata_list, function(tbl) { 
        colnames(tbl) = c('vehicle', 'time', 'position', 'speed')
        tbl[, c(3, 4)] = tbl[, c(3, 4)] * 0.3048 
        return(tbl)
    })
    saveRDS(vdata_list, ngsim_file)
} else {
    vdata_list = readRDS(ngsim_file)
}
