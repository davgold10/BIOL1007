#### ggplot2
#### 24 Jan 2023
#### DG

library(ggplot2)
library(ggthemes)
library(patchwork)

#### Template for ggplot code
### ggplot(data=<DATA>, mapping  aes(x = xVar, y = yVar)) + 
### <GEOM FUNCTION> ##geom_boxplot()
### print(p1)

#### Load in a built in dataset
d <- mpg
str(mpg)

library(dplyr)
glimpse(d)

#### qplot: quick, plotting
qplot(x=d$hwy)

# histogram
qplot(x=d$hwy, fill = I("darkblue"), color = I("black"))

# scatterplot
qplot(x=d$displ, y=d$hwy, geom=c("smooth", "point"), method="lm")

# boxplot
qplot(x=d$fl, y=d$cty, geom="boxplot", fill=I("forestgreen"))

# barplot
qplot(x=d$fl, geom="bar", fill=I("forestgreen"))

### Create some data(specified counts)
x_trt <- c("Control", "Low", "High")
y_resp <- c(12, 2.5, 22.9)
qplot(x=x_trt, y=y_resp, geom="col", fill=I(c("forestgreen", "slategray", "goldenrod")))

#### ggplot: uses dataframes instead of vectors

p1 <- ggplot(data=d, mapping=aes(x=displ, y=cty, color = cyl)) + geom_point()
p1

p1 + theme_base()
p1 + theme_bw()
p1 + theme_classic()
p1 + theme_linedraw()
p1 + theme_dark()

p2 <- ggplot(data=d, aes(x=fl, fill=fl)) + 
  geom_bar()
p2 + coord_flip()

# theme modifications
p3 <- ggplot(data=d, aes(x=displ, y=cty)) +
  geom_point(size=7, shape=21, color="magenta", fill="black") +
  xlab("Count") +
  ylab("Fuel") +
  labs(title="My title here", subtitle="my subtitle goes here") #x=/y= axis
p3 + xlim(1,10) +
  ylim(0,35)

library(viridis)
colVirds <- viridis(7, option = "magma")
ggplot(data = d, aes(x=class, y=hwy, fill=class)) + geom_boxplot() +
  scale_fill_manual(values=colVirds)
