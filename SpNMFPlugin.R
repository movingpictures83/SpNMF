library('SpNMF')

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
  spdata.train <<- read.csv(toString(parameters["training",2]), header = TRUE, row.names=1);
  spdata.test <<- read.csv(toString(parameters["testing",2]), header = TRUE, row.names=1);
  ytrain <<- as.numeric(read.csv(toString(parameters["traininggroups",2])));
}


run <- function() {
  #cn <<- spdata.train[,1];
  #spdata.train <<- spdata.train[,-1];
  spdata.train <<- apply(spdata.train, 1, as.numeric);
  #spdata.test <<- spdata.test[,-1];
  spdata.test <<- apply(spdata.test, 1, as.numeric);
  spdata.train <<- as.matrix(spdata.train)
  spdata.train <<- t(spdata.train)
  spdata.test <<- as.matrix(spdata.test)
  spdata.test <<- t(spdata.test)
  #remove all zero columns
  spdata.train.rm<<-spdata.train[,colSums(spdata.train)!=0]
  #remove the same variables from test data
  spdata.test.rm<<-spdata.test[,colSums(spdata.train)!=0]
  #y<<-c(rep(1,4),rep(0,4))
  #y.train<<-y.test<<-c(rep(1 ,2),rep(0,2))
  ytrain<<-c(rep(1,2), rep(0,2))
  T.eg<<-getT(spdata.train.rm,ytrain,2,3)
  rs.train<<-spnmf(spdata.train.rm,T.eg)
  w.train<<-rs.train$W
  rs.test<<-spnmf(spdata.test.rm,T.eg)
  w.test<<-rs.test$W
  #pc <<- t(pc);
  #pc <<- as.matrix(vegdist(pc, method="canberra"))
}

output <- function(outputfile) {
   md.train=glm(ytrain~.,data=data.frame(w.train),family=binomial(link=logit))
   pred=predict(md.train,newdata=data.frame(w.test),type ="response")
   write.table(as.matrix(pred), file=outputfile, sep=",", append=FALSE, na="");
}


